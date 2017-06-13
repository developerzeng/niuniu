//
//  TimeIntervalTransform.swift
//  YunGou
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 bangma. All rights reserved.
//

import Foundation
import ObjectMapper

public class TimeIntervalTransform: TransformType {
	public typealias Object = Date
	public typealias JSON = Double

	public init() { }

	public func transformFromJSON(_ value: Any?) -> Date? {
		if let timeInt = value as? Double {
			return Date(timeIntervalSince1970: TimeInterval(timeInt ))
		}

		if let timeStr = value as? String {
			return Date(timeIntervalSince1970: TimeInterval(atof(timeStr) ))
		}

		return nil
	}

	public func transformToJSON(_ value: Date?) -> Double? {
		if let date = value {
			return Double(date.timeIntervalSince1970)
		}
		return nil
	}
}
