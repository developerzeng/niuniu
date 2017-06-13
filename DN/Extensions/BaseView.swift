//
//  BaseView.swift
//  ShenSu
//
//  Created by shensu on 17/5/31.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class BaseView: UIView {
	var contentView: UIView!
	// 加载xib
	func loadViewFromNib() -> UIView {
		let className = type(of: self)
		let bundle = Bundle(for: className)
		let name = NSStringFromClass(className).components(separatedBy: ".").last
		let nib = UINib(nibName: name!, bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
		return view
	}
	// 初始化时将xib中的view添加进来
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		contentView = loadViewFromNib()
		addSubview(contentView)

	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView = loadViewFromNib()

		addSubview(contentView)
	}
	override func layoutSubviews() {
		contentView.frame = self.frame
	}
	/*
	 // Only override draw() if you perform custom drawing.
	 // An empty implementation adversely affects performance during animation.
	 override func draw(_ rect: CGRect) {
	 // Drawing code
	 }
	 */

}
