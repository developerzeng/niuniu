//
//  GameModel.swift
//  DN
//
//  Created by shensu on 17/6/13.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class GameModel: NSObject , NSCopying {
    var pukenumber:String!
    var ischoose:Bool = false
    func copy(with zone: NSZone? = nil) -> Any {
        
       
        return self
    }
 
}
