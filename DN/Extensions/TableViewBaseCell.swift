//
//  TableViewBaseCell.swift
//  YunGou
//
//  Created by Apple on 16/5/24.
//  Copyright © 2016年 bangma. All rights reserved.
//

import UIKit

class TableViewBaseCell: UITableViewCell {

    var imageSize: CGSize = CGSize(width:60, height:60)

	var onlyChangeImage: Bool = false

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		imageView?.frame.size = imageSize
		imageView?.y = (height - imageSize.height) / 2.0
		imageView?.layer.cornerRadius = imageSize.height / 2.0
		imageView?.layer.masksToBounds = true
		if !onlyChangeImage {
			textLabel?.x = imageView!.maxX + 20
			textLabel?.width = 160 - textLabel!.x - 20
		} else {
			textLabel?.x = imageView!.maxX + 16
			textLabel?.width = self.width - imageView!.maxX - 32
			detailTextLabel?.x = imageView!.maxX + 16
			detailTextLabel?.width = self.width - imageView!.maxX - 32
		}
	}

}
