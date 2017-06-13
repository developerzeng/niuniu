//
//  NavViewController.swift
//  YunGou
//
//  Created by Apple on 16/5/17.
//  Copyright © 2016年 bangma. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		if self.viewControllers.count >= 1 {
			viewController.hidesBottomBarWhenPushed = true
		}

		super.pushViewController(viewController, animated: animated)
	}
}

extension UINavigationController {
	func popToViewController(viewClass: AnyClass) {
		var vc: UIViewController?
		self.viewControllers.forEach { (view) in
			if view.isKind(of: viewClass) {
				vc = view
			}
		}
		if let viewController = vc {
			self.popToViewController(viewController, animated: true)
		}
	}
}
