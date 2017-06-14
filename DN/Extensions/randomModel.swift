//
//  randomModel.swift
//  ShenSu
//
//  Created by shensu on 17/5/17.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class randomModel: NSObject {
	public static let `default` = randomModel()
  
	func setRandomfrom(fromNumber: Int, toNumber: Int, red: Int) -> Array<String>? {
		let redArray = randomfrom(fromNumber: fromNumber, toNumber: toNumber, number: red)
		return redArray
	}
	func setRandomfrom(fromNumber: Int, toNumber: Int, red: Int, bluefrom: Int?, toBlue: Int?, blue: Int?) -> Array<String>? {
		var redArray = randomfrom(fromNumber: fromNumber, toNumber: toNumber, number: red)
		var blueArray: Array<String>
		if blue != nil {
			blueArray = randomfrom(fromNumber: bluefrom!, toNumber: toBlue!, number: blue!)
			redArray += blueArray
		}

		return redArray
	}
	private func randomfrom(fromNumber: Int, toNumber: Int, number: Int) -> Array<String> {
		var numberArray = Array<String>()
		for _ in 0..<number {
			var y: String
			repeat {
				y = setX(fromNumber: fromNumber, toNumber: toNumber)
			} while numberArray.contains(y)

			numberArray.append(y)

		}

		return numberArray.sorted()
	}
	private func setX(fromNumber: Int, toNumber: Int) -> String {
		let max: UInt32 = UInt32(toNumber)
		let min: UInt32 = UInt32(fromNumber)
		let x = arc4random_uniform(max - min) + min
		return String(format: "%d", x)
	}
    
  
}
