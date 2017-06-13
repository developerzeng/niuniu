//
//  UIScreenExtensions.swift
//  Joy
//
//  Created by Apple on 16/5/9.
//  Copyright © 2016年 AppES. All rights reserved.
//

import UIKit

extension UIScreen {
	static var size: CGSize {
		return UIScreen.main.bounds.size
	}

	static var width: CGFloat {
		return UIScreen.main.bounds.width
	}

	static var height: CGFloat {
		return UIScreen.main.bounds.size.height
	}
}
