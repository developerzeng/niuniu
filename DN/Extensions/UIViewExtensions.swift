//
//  UIViewExtensions.swift
//  Joy
//
//  Created by Apple on 16/5/6.
//  Copyright © 2016年 AppES. All rights reserved.
//

import UIKit

import Kingfisher

private var nameKey: UInt = 0
extension UIView {
	var name: String? {
		get {
			return objc_getAssociatedObject(self, &nameKey) as? String
		}
		set {
			objc_setAssociatedObject(self, &nameKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	var x: CGFloat {
		get {
			return self.frame.minY
		}
		set {
			self.frame.origin.x = newValue
		}
	}

	var y: CGFloat {
		get {
			return self.frame.minY
		}
		set {
			self.frame.origin.y = newValue
		}
	}

	var width: CGFloat {
		get {
			return self.frame.width
		}
		set {
			self.frame.size.width = newValue
		}
	}

	var height: CGFloat {
		get {
			return self.frame.height
		}
		set {
			self.frame.size.height = newValue
		}
	}

	var size: CGSize {
		get {
			return CGSize(width: self.width, height: self.height)
		}
		set {
			self.frame.size = newValue
		}
	}

	var minX: CGFloat {
		return self.frame.minX
	}

	var maxX: CGFloat {
		return self.frame.maxX
	}

	var minY: CGFloat {
		return self.frame.minY
	}

	var maxY: CGFloat {
		return self.frame.maxY
	}

	var calculateSize: CGSize {
		self.layoutIfNeeded()
		return self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
	}

	func addSubviews(views: [UIView]) {
		views.enumerated().forEach { (_, view) in
			self.addSubview(view)
		}

	}
	var devicesize: CGSize {
		return UIScreen.main.bounds.size
	}
	var ownerViewController: UIViewController? {
		var vc: UIViewController? = nil

		var w = UIApplication.shared.keyWindow
		if w != nil && w!.windowLevel != UIWindowLevelNormal {
			let windows = UIApplication.shared.windows
			for item in windows {
				if item.windowLevel == UIWindowLevelNormal {
					w = item
					break
				}
			}
		}

		if let frontView = window?.subviews[0] {
			if let nextResponder = frontView.next {
				if nextResponder.isKind(of: UIViewController.classForCoder()) {
					vc = nextResponder as? UIViewController
				} else {
					vc = window?.rootViewController
				}
			}
		}

		return vc
	}
}

extension UIImageView {
	public func setImageNotplaceholder(url: String) {
		if NSURL(string: url) != nil {
			let resoure = URL(string: url)!
			self.kf.setImage(with: resoure)
		}
	}
	public func setImageWithURL(url: String) {
		if NSURL(string: url) != nil {

			let resoure = URL(string: url)!
			self.kf.setImage(with: resoure, placeholder: UIImage(named: "DefaultImage")!, options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)

		}
	}

	public func setKingfisherImageWithURL(url: String, placeholderImage: UIImage) {
		if NSURL(string: url) != nil {
			let resoure = URL(string: url)!
			self.kf.setImage(with: resoure, placeholder: placeholderImage, options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
		}
	}

	public func setImageWithURLBlcok(url: String, placeholderImage: UIImage, completed: @escaping () -> Void) {
		if NSURL(string: url) != nil {
			let resoure = URL(string: url)!
			self.kf.setImage(with: resoure, placeholder: placeholderImage, options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: { (image, error, cachtypr, url) in
				completed()
			})

		}
	}
}


extension UITableView {
    
 
	public func removfootViewLine() {
		self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, w: self.width, h: 0.01))
	}
	public func safeReload() {
		if Thread.current.isMainThread {
			self.reloadData()
		} else {
			DispatchQueue.main.async(execute: {
				self.reloadData()
			})

		}
	}
    
}

extension UICollectionView {
	public func safeReload() {
		if Thread.current.isMainThread {
			self.reloadData()
		} else {
			DispatchQueue.main.async(execute: {
				self.reloadData()
			})
		}
	}
}

extension UIButton {
    
    @objc public enum ImageButtonType: UInt {
        case ImageButtonLeft = 0
        case ImageButtonTop = 1
        case ImageButtonBottom = 2
        case ImageButtonRight = 3
    }
    @objc public func imageButtonInsetsType(type: ImageButtonType, imagewithTitleSpace space: CGFloat) {
        let imageWidth = self.imageView?.intrinsicContentSize.width ?? 0
        let imageHeight = self.imageView?.intrinsicContentSize.height ?? 0
        let lableWidth = self.titleLabel?.intrinsicContentSize.width ?? 0
        let lableHeight = self.titleLabel?.intrinsicContentSize.height ?? 0
        
        var imageInsets = UIEdgeInsets.zero
        var lableInsets = UIEdgeInsets.zero
        switch type {
        case .ImageButtonTop:
            imageInsets = UIEdgeInsets(top: -lableHeight - space / 2, left: 0, bottom: 0, right: -lableWidth)
            lableInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space / 2.0, right: 0)
        case .ImageButtonBottom:
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -lableHeight - space / 2, right: -lableWidth)
            lableInsets = UIEdgeInsets(top: -imageHeight - space / 2, left: -imageWidth, bottom: 0, right: 0)
        case .ImageButtonRight:
            imageInsets = UIEdgeInsets(top: 0, left: lableWidth + space / 2, bottom: 0, right: -lableWidth - space / 2)
            lableInsets = UIEdgeInsets(top: 0, left: -imageWidth - space / 2, bottom: 0, right: imageWidth + space / 2)
        default:
            imageInsets = UIEdgeInsets(top: 0, left: -space / 2.0, bottom: 0, right: -space / 2)
            lableInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: -space / 2)
            break
            
        }
        self.titleEdgeInsets = lableInsets
        self.imageEdgeInsets = imageInsets
    }
}
