//
//  UIImageExtensions.swift
//  Joy
//
//  Created by Apple on 16/3/24.
//  Copyright © 2016年 AppES. All rights reserved.
//

import UIKit
import Accelerate

// MARK: - UIImage
extension UIImage {
	private var kBitPerComponent: Int {
		return 8
	}

	private var kBitmapInfo: CGImageAlphaInfo {
		return .premultipliedFirst
	}

	public func renderAtSize(size: CGSize) -> UIImage {
		UIGraphicsBeginImageContext(size)
		let context = UIGraphicsGetCurrentContext()
		self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
		let cgImage = context!.makeImage()
		let renderedImage = UIImage(cgImage: cgImage!)
		UIGraphicsEndImageContext()

		return renderedImage
	}

	public func renderWithCornerRadius(cornerRadius: CGFloat) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
		UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
		self.draw(in: rect)
		let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return modifiedImage!

	}

	public func scaleToSize(size: CGSize) -> UIImage {
		let bytesPerRow: Int = Int(size.width * 4.0)
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: kBitPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: kBitmapInfo.rawValue)
		let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
		context?.draw(self.cgImage!, in: rect)
		let scaledImageRef = context!.makeImage()
		let scaledImage = UIImage(cgImage: scaledImageRef!)

		return scaledImage
	}

	public func maskWithColor(color: UIColor) -> UIImage {
		let width = self.size.width
		let height = self.size.height
		let bounds = CGRect(x: 0, y: 0, width: width, height: height)
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: kBitPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: kBitmapInfo.rawValue)
		context!.clip(to: bounds, mask: self.cgImage!)
		context!.setFillColor(color.cgColor)
		context!.fill(bounds)
		let cgImage = context?.makeImage()
        
        let coloredImage = UIImage(cgImage: cgImage!)

		return coloredImage
	}
    public func maskWithColor(color: UIColor , size: CGSize) -> UIImage {
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: kBitPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: kBitmapInfo.rawValue)
        context!.clip(to: bounds, mask: self.cgImage!)
        context!.setFillColor(color.cgColor)
        context!.fill(bounds)
        let cgImage = context?.makeImage()
        
        let coloredImage = UIImage(cgImage: cgImage!)
        
        return coloredImage
    }
    public func creatImageWithColor(color:UIColor , size:CGSize)-> UIImage {
        let rect  = CGRect(x: 0, y: 0, w: size.width, h: size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
