//
//  TableViewController.swift
//  YunGou
//
//  Created by Apple on 16/5/24.
//  Copyright © 2016年 bangma. All rights reserved.
//

import UIKit

class TableViewController : BaseViewController, UITableViewDataSource, UITableViewDelegate {

	private(set) var tableView: UITableView!

	var frame: CGRect {
        return CGRect(x:0, y:0, width:view.width, height:view.height - footerViewHeight)
	}

	private(set) var footerView = UIView()

	var contentEdge: UIEdgeInsets {
		return UIEdgeInsets.zero
	}

	var footerViewHeight: CGFloat {
		return 0
	}

	var tableViewStyle: UITableViewStyle {
		return .plain
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		prepareLayout()
	}

	func setup() {
		tableView = UITableView(frame: frame, style: tableViewStyle)
        tableView.tableHeaderView = UIView(frame: CGRect(x:0, y:0, width:0, height:0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x:0, y:0, width:0, height:0.01))
		tableView.backgroundColor = UIColor(rgb: 0xf2f2f2)
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.delegate = self
		self.view.addSubview(tableView)

		footerView.backgroundColor = UIColor.clear
		self.view.addSubview(footerView)
	}

	private func prepareLayout() {
		tableView?.translatesAutoresizingMaskIntoConstraints = false
		footerView.translatesAutoresizingMaskIntoConstraints = false
		let constraints =
			NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[view]-right-|", options: [], metrics: ["left": contentEdge.left, "right": contentEdge.right], views: ["view": tableView]) +
			NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": footerView]) +
			NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[view1]-bottom-[view2(height)]|", options: [], metrics: ["height": footerViewHeight, "top": contentEdge.top, "bottom": contentEdge.bottom], views: ["view1": tableView, "view2": footerView])

		NSLayoutConstraint.activate(constraints)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	func tableView(_ cellForRowAttableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.01
	}

	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.01
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
