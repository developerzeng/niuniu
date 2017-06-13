//
//  UIColor+Ext.swift
//  Joy
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 AppES. All rights reserved.
//

import UIKit

func RGB(rgb: UInt32) -> UIColor {
	return UIColor(rgb: rgb)
}

func RGB(rgb: UInt32, alpha: CGFloat) -> UIColor {
	return UIColor(rgb: rgb, alpha: alpha)
}

extension UIColor {
	convenience init(rgb: UInt32) {
		let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
		let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
		let b = CGFloat((rgb & 0x0000FF)) / 255.0

		self.init(red: r, green: g, blue: b, alpha: 1.0)
	}

	convenience init(rgb: UInt32, alpha: CGFloat) {
		let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
		let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
		let b = CGFloat((rgb & 0x0000FF)) / 255.0

		self.init(red: r, green: g, blue: b, alpha: alpha)
	}

	convenience init(_ colorString: String) {
		var red: CGFloat = 0.0
		var green: CGFloat = 0.0
		var blue: CGFloat = 0.0
		var alpha: CGFloat = 1.0

		if colorString.hasPrefix("#") {

			let index = colorString.index(colorString.startIndex, offsetBy: 1)
			let hex = colorString.substring(from: index)
			let scanner = Scanner(string: hex)
			var hexValue: CUnsignedLongLong = 0
			if scanner.scanHexInt64(&hexValue) {
				switch (hex.characters.count) {
				case 3:
					red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
					green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
					blue = CGFloat(hexValue & 0x00F) / 15.0
				case 4:
					red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
					green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
					blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
					alpha = CGFloat(hexValue & 0x000F) / 15.0
				case 6:
					red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
					green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
					blue = CGFloat(hexValue & 0x0000FF) / 255.0
				case 8:
					red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
					green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
					blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
					alpha = CGFloat(hexValue & 0x000000FF) / 255.0
				default:
					print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
				}
			} else {
				print("Scan hex error")
			}
		} else {
			print("Invalid RGB string, missing '#' as prefix", terminator: "")
		}
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}

extension UIColor {
	class func navyColor() -> UIColor {
		return UIColor("#000080")
	}

	class func darkBlueColor() -> UIColor {
		return UIColor("#00008B")
	}

	class func mediumBlueColor() -> UIColor {
		return UIColor("#0000CD")
	}

	class func darkGreenColor() -> UIColor {
		return UIColor("#006400")
	}

	class func tealColor() -> UIColor {
		return UIColor("#008080")
	}

	class func oliveColor() -> UIColor {
		return UIColor("#808000")
	}

	class func darkCyanColor() -> UIColor {
		return UIColor("#008B8B")
	}

	class func darkSkyBlueColor() -> UIColor {
		return UIColor("#00BFFF")
	}

	class func yellowGreenColor() -> UIColor {
		return UIColor("#9ACD32")
	}
	/// 紫罗兰色
	class func blueVioletColor() -> UIColor {
		return UIColor("#8A2BE2")
	}

	class func darkVioletColor() -> UIColor {
		return UIColor("##9400D3")
	}

	class func darkTurquoiseColor() -> UIColor {
		return UIColor("#00CED1")
	}

	class func fireBrickColor() -> UIColor {
		return UIColor("#B22222")
	}

	class func maroonColor() -> UIColor {
		return UIColor("#800000")
	}

	class func mediumSpringGreenColor() -> UIColor {
		return UIColor("#00FA9A")
	}

	class func springGreenColor() -> UIColor {
		return UIColor("#00FF7F")
	}
	/// 浅绿色
	class func aquaColor() -> UIColor {
		return UIColor("#00FFFF")
	}

	class func midnightBlueColor() -> UIColor {
		return UIColor("#191970")
	}

	class func lightSeaGreenColor() -> UIColor {
		return UIColor("#20B2AA")
	}

	class func forestGreenColor() -> UIColor {
		return UIColor("#228B22")
	}

	class func seaGreenColor() -> UIColor {
		return UIColor("#2E8B57")
	}

	class func limeGreenColor() -> UIColor {
		return UIColor("#32CD32")
	}

	class func deepPinkColor() -> UIColor {
		return UIColor("#FF1493")
	}

	class func mediumSeaGreenColor() -> UIColor {
		return UIColor("#3CB371")
	}

	class func royalBlueColor() -> UIColor {
		return UIColor("#4169E1")
	}

	class func steelBlueColor() -> UIColor {
		return UIColor("#4682B4")
	}

	class func orangeRedColor() -> UIColor {
//		return UIColor("#FF4500")
		return UIColor("#FF0000")
	}

	class func tomatoColor() -> UIColor {
		return UIColor("#FF6347")
	}

	class func indigoColor() -> UIColor {
		return UIColor("#4B0082")
	}

	class func hotPinkColor() -> UIColor {
		return UIColor("#FF69B4")
	}

	class func lightPinkColor() -> UIColor {
		return UIColor("#FFB6C1")
	}

	class func lightColor() -> UIColor {
		return UIColor("#FFC0CB")
	}

	class func pinkColor() -> UIColor {
		return UIColor("#FFC0CB")
	}

	class func goldColor() -> UIColor {
		return UIColor("#FFD700")
	}

	class func seaShellColor() -> UIColor {
		return UIColor("#FFF5EE")
	}

	class func snowColor() -> UIColor {
		return UIColor("#FFFAFA")
	}

	class func lightYellowColor() -> UIColor {
		return UIColor("#FFFFF0")
	}

	class func ivoryColor() -> UIColor {
		return UIColor("#FFFFE0")
	}
	class func backColor() -> UIColor {
		return UIColor("#f2f2f2")
	}
}

extension UIColor {
	static func random() -> UIColor {
		return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
	}
}
