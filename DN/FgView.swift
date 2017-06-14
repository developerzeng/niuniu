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
                Left(0).to(self, .left),
                Right(0).to(self, .right),
                Height(110)
                ]
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.removeFromSuperview()
                    self.beginBtnBlock?()
                })
            }else{
            
                let beginBtn = UIButton(type: .custom)
                beginBtn.setBackgroundImage(UIImage.init(named: "button_star"), for: .normal)
                beginBtn.setTitleColor(UIColor.white, for: .normal)
                beginBtn.layer.cornerRadius = 4
                beginBtn.addTarget(self, action: #selector(beginBtnClick), for: .touchUpInside)
                self.addSubview(beginBtn)
                beginBtn <- [
                   Center(0),
                   Size(CGSize(width: 115, height: 35))
                ]

            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.3)
        
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
