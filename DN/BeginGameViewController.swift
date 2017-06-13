//
//  BeginGameViewController.swift
//  DN
//
//  Created by shensu on 17/6/12.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class BeginGameViewController: UIViewController {

    @IBOutlet weak var beginImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let tap = UITapGestureRecognizer(target: self, action: #selector(beginGameTap))
        beginImage.isUserInteractionEnabled = true
        beginImage.addGestureRecognizer(tap)
        beginImage <- [
        Edges(0)
        ]
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTransparentNavBar(flag: true)
    }
    func beginGameTap(){
        let vc = GameViewController()
        _ = self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    convenience init() {
        
        var nibNameOrNil = String?("BeginGameViewController")
        
        //考虑到xib文件可能不存在或被删，故加入判断
        
        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil
            
        {
            
            nibNameOrNil = nil
            
        }
        
        self.init(nibName: nibNameOrNil, bundle: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
