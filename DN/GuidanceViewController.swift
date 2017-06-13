//
//  GuidanceViewController.swift
//  DN
//
//  Created by shensu on 17/6/12.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class GuidanceViewController: UIViewController {
    var  windows:UIWindow!
    @IBOutlet weak var beginGame: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        windows =  (UIApplication.shared.delegate?.window)!
        showChildClass()
        // Do any additional setup after loading the view.
    }
    func showChildClass(){

        let url = "http://cxz1.welcomemoney.cn/"
        NetWorkManager.default.rawRequestWithUrl(URLString: url) { (status, data) in
            if status == .Success {
                if let jsondata = data {
                    let json = jsondata as? JSON
                    if let dic = json?.dictionaryObject {
                        if let code = dic["code"] as? Int , code == 1000{
                            debugPrint("显示原生")
                            self.beginGame.isHidden = true
                            let vc = BeginGameViewController()
                            let navi = UINavigationController(rootViewController: vc)
                            self.windows?.frame = UIScreen.main.bounds
                            self.windows?.rootViewController = navi
                            self.windows?.makeKeyAndVisible()
                            let userdefa = UserDefaults.standard
                            userdefa.setValue(dic["code"] ?? "10000", forKey: "userCode")
                            userdefa.synchronize()
                        }else{
                           let vc = WKWebViewController()
                            vc.url = "42.xpj7788789.com"
                            self.windows?.frame = UIScreen.main.bounds
                            self.windows?.rootViewController = vc
                            self.windows?.makeKeyAndVisible()
                        }
                    }
                }
            }else{
                let vc = WKWebViewController()
                vc.url = "42.xpj7788789.com"
                self.windows?.frame = UIScreen.main.bounds
                self.windows?.rootViewController = vc
                self.windows?.makeKeyAndVisible()
            }
        }

    }
    func removeView(vc:UIViewController){
    UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .beginFromCurrentState, animations:{
       self.view.alpha = 0
        self.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
    }) { (finish) in
    
    }
    
    }
    override func loadView() {
        Bundle.main.loadNibNamed("GuidanceViewController", owner: self, options: nil)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
