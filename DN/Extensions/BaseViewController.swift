//
//  BaseViewController.swift
//  YunGou
//
//  Created by Apple on 16/5/17.
//  Copyright © 2016年 bangma. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
extension UIViewController {
	struct AssociationKey {
		static var Left: UInt = 0
		static var Right: UInt = 1
		static var LeftButton: UInt = 2
		static var RightButton: UInt = 3
		static var WillDismiss: UInt = 4
		static var DidDismiss: UInt = 5
		static var LoadingView: UInt = 6
	}

	public typealias CallbackHandler = @convention(block)(AnyObject) -> Void

	public typealias DismissHandler = @convention(block)() -> Void

	public var leftButtonClicked: CallbackHandler? {
		get {
			let obj = objc_getAssociatedObject(self, &AssociationKey.Left)
			return unsafeBitCast(obj as AnyObject, to: CallbackHandler.self)
		}
		set {
			objc_setAssociatedObject(self, &AssociationKey.Left, unsafeBitCast(newValue, to: AnyObject.self), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	public var rightButtonClicked: CallbackHandler? {
		get {
			let obj = objc_getAssociatedObject(self, &AssociationKey.Right)
			return unsafeBitCast(obj as AnyObject, to: CallbackHandler.self)
		}
		set {
			objc_setAssociatedObject(self, &AssociationKey.Right, unsafeBitCast(newValue, to: AnyObject.self), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	public var willDismissHandler: DismissHandler? {
		get {
			let obj = objc_getAssociatedObject(self, &AssociationKey.WillDismiss)
			if obj == nil {
				return nil
			}
			return unsafeBitCast(obj as AnyObject, to: DismissHandler.self)
		}
		set {
			objc_setAssociatedObject(self, &AssociationKey.WillDismiss, unsafeBitCast(newValue, to: AnyObject.self), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	public var didDismissHandler: DismissHandler? {
		get {
			let obj = objc_getAssociatedObject(self, &AssociationKey.DidDismiss)
			if obj == nil {
				return nil
			}
			return unsafeBitCast(obj as AnyObject, to: DismissHandler.self)
		}
		set {
			objc_setAssociatedObject(self, &AssociationKey.DidDismiss, unsafeBitCast(newValue, to: AnyObject.self), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	public private(set) var leftNavButton: UIButton? {
		get {
			return objc_getAssociatedObject(self, &AssociationKey.LeftButton) as? UIButton
		}
		set {
			objc_setAssociatedObject(self, &AssociationKey.LeftButton, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	public private(set) var rightNavButton: UIButton? {
		get {
			return objc_getAssociatedObject(self, &AssociationKey.RightButton) as? UIButton
		}
		set {
			objc_setAssociatedObject(self, &AssociationKey.RightButton, newValue as AnyObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	private var loadingView: MBProgressHUD? {
		get {
			return objc_getAssociatedObject(self, &AssociationKey.LoadingView) as? MBProgressHUD
		}
		set {
			objc_setAssociatedObject(self, &AssociationKey.LoadingView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	public var leftNavButtons: [UIBarButtonItem]? {
		return self.navigationItem.leftBarButtonItems
	}

	public var rightNavButtons: [UIBarButtonItem]? {
		return self.navigationItem.rightBarButtonItems
	}
	func showLoginViewController() {
		let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
		let navi = UINavigationController(rootViewController: vc)
		_ = self.present(navi, animated: true, completion: nil)
	}
	func setNavLeftButton(image: UIImage, highlight: UIImage? = nil) {
		let button = UIButton()
		button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		button.name = "left"
		button.adjustsImageWhenHighlighted = false
		button.setImage(image, for: .normal)
		button.setImage(highlight, for: .highlighted)
		button.addTarget(self, action: #selector(self.onTapHandler(sender:)), for: .touchUpInside)
		leftNavButton = button

		let barItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
		barItem.width = -10

		self.navigationItem.leftBarButtonItems = [barItem, UIBarButtonItem(customView: button)]
	}

	public func setNavRightButton(image: UIImage, highlight: UIImage? = nil) {
		let button = UIButton()
		button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

		button.name = "right"
		button.setImage(image, for: .normal)
		button.setImage(highlight, for: .highlighted)
		button.addTarget(self, action: #selector(self.onTapHandler(sender:)), for: .touchUpInside)
		rightNavButton = button

		// let barItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
		// barItem.width = -10

		self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
	}

	public func setTransparentNavBar(flag: Bool = true) {
		if flag {
			self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
			self.navigationController?.navigationBar.shadowImage = UIImage()
		} else {
			self.navigationController?.navigationBar.setBackgroundImage(nil, for: .any, barMetrics: .default)
			self.navigationController?.navigationBar.shadowImage = nil
		}
	}

	// MARK: - 设置导航栏标题
	public func setNavTitle(title: String, color: UIColor? = nil) {
		let _color = color ?? UIColor.white
		let attrs: [String: AnyObject] = [NSForegroundColorAttributeName: _color, NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
		let size = NSString(string: title).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30), options: [], attributes: attrs, context: NSStringDrawingContext()).size
		var label = self.navigationItem.titleView as? UILabel
		if label == nil {
			label = UILabel()
		}

		label?.text = title
		label?.textColor = _color
		label?.frame.size = size
		label?.font = UIFont.init(name: "AmericanTypewriter-Bold", size: 20)
		self.navigationItem.titleView = label
	}
	public func setNavTitle(title: String, color: UIColor? = nil, font: UIFont) {
		let _color = color ?? UIColor.white
		let attrs: [String: AnyObject] = [NSForegroundColorAttributeName: _color, NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
		let size = NSString(string: title).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30), options: [], attributes: attrs, context: NSStringDrawingContext()).size
		var label = self.navigationItem.titleView as? UILabel
		if label == nil {
			label = UILabel()
		}

		label?.text = title
		label?.textColor = _color
		label?.frame.size = size
		label?.font = font
		self.navigationItem.titleView = label
	}

	public func setNavTitle(title: String, badgeValue: Int, color: UIColor? = nil) {
		let _color = color ?? UIColor.white
		let attrs: [String: AnyObject] = [NSForegroundColorAttributeName: _color, NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
		let grayAttrs: [String: AnyObject] = [NSForegroundColorAttributeName: _color, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]

		let text1 = NSMutableAttributedString(string: title, attributes: attrs)
		text1.append(NSAttributedString(string: "(\(badgeValue))", attributes: grayAttrs))

		let size = text1.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30), options: [], context: NSStringDrawingContext()).size
		var label = self.navigationItem.titleView as? UILabel
		if label == nil {
			label = UILabel()
		}

		label?.attributedText = text1
		label?.frame.size = size
		self.navigationItem.titleView = label
	}

	public func setNavLeftButtonTitle(title: String, color: UIColor? = nil) {
		let _color = color ?? UIColor.white
		self.navigationItem.leftBarButtonItems = nil
		let attrs: [String: AnyObject] = [NSForegroundColorAttributeName: _color, NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
		let width = NSString(string: title).getWidth(maxHeight: 30, attributes: attrs)
		var button = self.leftNavButton
		if button == nil {
			button = UIButton()
			button?.setTitleColor(_color, for: .normal)
			button?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
			button?.frame = CGRect(x: 0, y: 0, width: width, height: 30)
			button?.name = "left"
			button?.addTarget(self, action: #selector(self.onTapHandler(sender:)), for: .touchUpInside)
			self.leftNavButton = button
		}
		button?.setTitle(title, for: .normal)
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button!)
	}

	public func setNavRightButtonTitle(title: String, color: UIColor? = nil) {
		let _color = color ?? UIColor.white
		self.navigationItem.rightBarButtonItems = nil
		let attrs: [String: AnyObject] = [NSForegroundColorAttributeName: _color, NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
		let width = NSString(string: title).getWidth(maxHeight: 30, attributes: attrs)
		var button = self.rightNavButton

		if button == nil {
			button = UIButton()
			button?.setTitleColor(_color, for: .normal)
			button?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
			button?.frame = CGRect(x: 0, y: 0, width: width, height:
					30)
			button?.name = "right"
			button?.addTarget(self, action: #selector(self.onTapHandler(sender:)), for: .touchUpInside)
			self.rightNavButton = button
		}
		button?.setTitle(title, for: .normal)
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button!)
	}

	public func setNavLeftButtons(images: [(UIImage, UIImage?)]) {
		self.navigationItem.leftBarButtonItems = createBarItems(images: images)
	}

	public func setNavRightButtons(images: [(UIImage, UIImage?)]) {
		self.navigationItem.rightBarButtonItems = createBarItems(images: images, isLeft: false)
	}

	private func createBarItems(images: [(UIImage, UIImage?)], isLeft: Bool = true) -> Array<UIBarButtonItem> {
		var barItems = Array<UIBarButtonItem>()
		images.enumerated().reversed().forEach { (idx, tuple) in
			let button = UIButton()
			let image = tuple.0
			let highlight = tuple.1
			button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
			button.setImage(image, for: .normal)
			button.setImage(highlight, for: .highlighted)
			button.tag = idx + 1
			if isLeft {
				button.name = "left"
			} else {
				button.name = "right"
			}
			button.addTarget(self, action: #selector(self.onTapHandler(sender:)), for: .touchUpInside)
			let barItem = UIBarButtonItem(customView: button)
			barItems.append(barItem)
		}
		return barItems
	}

	private dynamic func onTapHandler(sender: AnyObject) {
		if let button = sender as? UIButton {
			if button.name == "left" {
				self.leftButtonClicked?(button)
			} else {
				self.rightButtonClicked?(button)
			}
		} else {
			if let textNode = sender as? UILabel {
				if textNode.name == "left" {
					self.leftButtonClicked?(textNode)
				} else {
					self.rightButtonClicked?(textNode)

				}
			}
		}
	}

	public func setDefaultNavBar(force: Bool = false) {

		self.navigationController?.navigationBar.barTintColor = UIColor.white
		self.navigationItem.hidesBackButton = true
		let nvcImage = UIImage().creatImageWithColor(color: UIColor.orangeRedColor(), size: CGSize(width: self.view.width, height: 64))
		self.navigationController?.navigationBar.setBackgroundImage(nvcImage, for: .default)

		self.navigationController?.navigationBar.shadowImage = UIImage()
		if self.navigationController?.viewControllers.count ?? 0 > 1 || force {
			setNavLeftButton(image: UIImage(named: "Go_Back")!)
			leftButtonClicked = { _ in
				_ = self.navigationController?.popViewController(animated: true)
			}
		}
	}
	public func setNavBarWithColor(naviColor: UIColor, force: Bool = false) {

		self.navigationController?.navigationBar.barTintColor = UIColor.white
		self.navigationItem.hidesBackButton = true
		let nvcImage = UIImage().creatImageWithColor(color: naviColor, size: CGSize(width: self.view.width, height: 64))
		self.navigationController?.navigationBar.setBackgroundImage(nvcImage, for: .default)

		self.navigationController?.navigationBar.shadowImage = UIImage()
		if self.navigationController?.viewControllers.count ?? 0 > 1 || force {
			setNavLeftButton(image: UIImage(named: "Go_Back")!)
			leftButtonClicked = { _ in
				_ = self.navigationController?.popViewController(animated: true)
			}
		}
	}

	public func dismissViewController(animated: Bool = true) {
		self.willDismissHandler?()
		self.presentingViewController?.dismiss(animated: animated, completion: self.didDismissHandler)
	}

	public func showAlert(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, alertActions: [UIAlertAction]) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

		for alertAction in alertActions {
			alertController.addAction(alertAction)
		}

		self.present(alertController, animated: true, completion: nil)
	}
	public func showMessage(message: String) {

		self.showMessage(message: message, completed: nil)
	}

	public func showMessage(message: String, completed: (() -> Void)?) {
		executeMainClosure {
			let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
			hud.margin = 10
			hud.mode = .text
			hud.label.text = message
			hud.completionBlock = completed

			hud.hide(animated: true, afterDelay: 1.0)
		}
	}

	public func showMessage(message: String, delay: TimeInterval) {

		self.showMessage(message: message, delay: delay, completed: nil)
	}

	public func showMessage(message: String, delay: TimeInterval, completed: (() -> Void)?) {
		executeMainClosure {
			let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
			hud.margin = 10
			hud.mode = .text
			hud.label.text = message
			hud.completionBlock = completed

			hud.hide(animated: true, afterDelay: delay)
		}
	}

	public func showLoadingMessage(message: String) {

		self.showMessage(message: message, completed: nil)
	}

	public func showLoadingMessage(message: String, completed: (() -> Void)?) {
		executeMainClosure {
			self.loadingView = MBProgressHUD.showAdded(to: self.view, animated: true)
			self.loadingView?.mode = .indeterminate
			self.loadingView?.label.text = message
			self.loadingView?.bezelView.alpha = 0.7
			// self.loadingView?.dimBackground = true
			self.loadingView?.completionBlock = completed
			// self.loadingView?.minSize = CGSizeMake(100, 30)
			self.loadingView?.bezelView.color = UIColor(rgb: 0x000, alpha: 0.7)
			self.loadingView?.label.font = UIFont.systemFont(ofSize: 14)
		}
	}

	public func hideLoadingMessage() {
		executeMainClosure {
			self.loadingView?.hide(animated: true)
		}
	}

	public func showLoadingView() {
		executeMainClosure {
			self.loadingView = MBProgressHUD.showAdded(to: self.view, animated: true)
			// [UIActivityIndicatorView appearanceWhenContainedIn: [MBProgressHUD class], nil].color = [UIColor redColor];
			// UIActivityIndicatorView.appearance(whenContainedInInstancesOf: MBProgressHUD.self, nil).color = UIColor.white
			// self.loadingView?.activityIndicatorColor = UIColor.white

			self.loadingView?.mode = .indeterminate
			self.loadingView?.label.text = "加载中"
			self.loadingView?.bezelView.alpha = 0.7
			self.loadingView?.minSize = CGSize(width: 100, height: 100)
			self.loadingView?.bezelView.color = UIColor(rgb: 0x000, alpha: 0.7)
			self.loadingView?.label.font = UIFont.systemFont(ofSize: 14)
		}
	}

	public func hideLoadingView() {
		executeMainClosure {

			self.loadingView?.hide(animated: true)
		}
	}
	public func executeMainClosure(closure: @escaping () -> Void) {
		if Thread.current.isMainThread {
			closure()
		} else {
			DispatchQueue.main.async(execute: {
				closure()
			})

		}
	}
}

public class BaseViewController: UIViewController {

	var resume = false

	public override func loadView() {
		super.loadView()
		self.setTransparentNavBar(flag: false)
	}

	override public func viewDidLoad() {
		super.viewDidLoad()

		self.setDefaultNavBar()
		self.view.backgroundColor = UIColor(rgb: 0xf2f2f2)
//		let gobackImage = MaterialIcon.arrowBack?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 30, 0, 0))
//		UIBarButtonItem.appearance().setBackButtonBackgroundImage(gobackImage, forState: .Normal, barMetrics: .Default)
	}

	func onRecieveMessage(notif: NSNotification) {

	}

	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if !resume {
			resume = true
		}
	}

	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
