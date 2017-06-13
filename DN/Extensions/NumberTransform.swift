//
//  NumberTransform.swift
//  YunGou
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 bangma. All rights reserved.
//

import UIKit
import ObjectMapper

public class NumberTransform: TransformType {
	public typealias Object = NSNumber

	public typealias JSON = String

	public func transformFromJSON(_ value: Any?) -> NSNumber? {
		if let newValue = value as? String {
			return newValue.toInt() as NSNumber?
		}
		return 0
	}

	public func transformToJSON(_ value: NSNumber?) -> String? {

		return value?.stringValue ?? ""
	}
}

public class IntTransform: TransformType {
	public typealias Object = Int

	public typealias JSON = String

	public func transformFromJSON(_ value: Any?) -> Int? {
		if let newValue = value as? String {
			return newValue.toInt()
		}
		return 0
	}

	public func transformToJSON(_ value: Int?) -> String? {

		return value?.toString
	}
}
