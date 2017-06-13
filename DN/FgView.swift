//
//  FgView.swift
//  DN
//
//  Created by shensu on 17/6/13.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class FgView: UIControl {
    var beginBtnBlock:(()->())?
    var result:Bool = false
    var isforce:Bool = false{
        didSet{
            if isforce == true {
            let imageView = UIImageView()
                
                imageView.image = result == true ?  UIImage(named: "win") : UIImage(named: "loses")
                self.addSubview(imageView)
                imageView <- [
                Center(0),
                Size(CGSize(width: 475/2, height: 110.0))
                ]
                
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.3)
        
        let beginBtn = UIButton(type: .custom)
        beginBtn.setTitle("开始", for: .normal)
        beginBtn.setTitleColor(UIColor.white, for: .normal)
        beginBtn.layer.cornerRadius = 4
        beginBtn.backgroundColor = UIColor.orangeRedColor()
        beginBtn.addTarget(self, action: #selector(beginBtnClick), for: .touchUpInside)
        self.addSubview(beginBtn)
        beginBtn <- [
        Left(80).to(self, .left),
        Right(80).to(self, .right),
        Height(44),
        Bottom(88).to(self, .bottom)
        ]
    }
    func beginBtnClick(){
    self.beginBtnBlock?()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
