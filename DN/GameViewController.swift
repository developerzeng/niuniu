//
//  GameViewController.swift
//  DN
//
//  Created by shensu on 17/6/12.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyJSON
class GameViewController: UIViewController {
    @IBOutlet weak var timeLable: UILabel!{
        didSet{
        timeLable.layer.cornerRadius = 15
        timeLable.layer.borderWidth = 1
        timeLable.layer.borderColor = UIColor.black.cgColor
        }
    }
    /// 下注钱数
    var priceXz:Int = 0
    /// 庄家点数
    var zhuanSum:Int = 0{
        didSet{
        zhuanLable.alpha = 1
        zhuanLable.text = numberChangeString(result: zhuanSum)
        }
    }
    /// 闲家点数
    var xianSum:Int = 0{
        didSet{
        xianLable.alpha = 1
        xianLable.text = numberChangeString(result: xianSum)
        }
    }
    /// 输赢
    var result:Bool {
        return zhuanSum >= xianSum ? false : true
    }
    /// 覆盖视图
    var fgView:FgView?
    /// 扑克数目
    var puckN = 52/4
    var pukeArray:Array<UIButton> {
    return [zhuanOne,zhuanTwo,zhuanThree, zhuanFour , zhuanFive,xianOne,xianTwo,xianThree , xianFour , xianFive]
    }
    var pukeNumbers = Array<GameModel>()
    @IBOutlet weak var zhuanFive: UIButton!{
        didSet{
            zhuanFive.tag = 1000
            zhuanFive.isUserInteractionEnabled = false
            zhuanFive.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    @IBOutlet weak var zhuanFour: UIButton!{
        didSet{
            zhuanFour.tag = 1001
            zhuanFour.isUserInteractionEnabled = false
            zhuanFour.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    @IBOutlet weak var zhuanThree: UIButton!{
        didSet{
        zhuanThree.tag = 1002
        zhuanThree.isUserInteractionEnabled = false
        zhuanThree.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
  
    @IBOutlet weak var zhuanTwo: UIButton!{
        didSet{
            zhuanTwo.tag = 1003
            zhuanTwo.isUserInteractionEnabled = false
            zhuanTwo.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var zhuanOne: UIButton!{
        didSet{
            zhuanOne.tag = 1004
            zhuanOne.isUserInteractionEnabled = false
            zhuanOne.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    @IBOutlet weak var xianFive: UIButton!{
        didSet{
            xianFive.tag = 1009
            xianFive.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var xianFour: UIButton!{
        didSet{
            xianFour.tag = 1008
            xianFour.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    
   
  
    @IBOutlet weak var xianThree: UIButton!{
        didSet{
            xianThree.tag = 1007
            xianThree.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    
   
 
    @IBOutlet weak var xianTwo: UIButton!{
        didSet{
            xianTwo.tag = 1006
            xianTwo.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    

    
    @IBOutlet weak var xianOne: UIButton!{
        didSet{
            xianOne.tag = 1005
            xianOne.addTarget(self, action: #selector(pukeBtnClick), for: .touchUpInside)
        }
    }
    /**
     摊牌
     
     - parameter sender: btn
     */
    @IBAction func changeAllBtnClick(_ sender: Any) {
        pukeArray.enumerated().forEach { (index,btn) in
            if index>4 {
            self.pukeBtnClick(btn: btn)
            }
        }
        
    }
    /// 摊牌
    @IBOutlet weak var changeAllBtn: UIButton!{
        didSet{
        changeAllBtn.adjustsImageWhenHighlighted = false
        changeAllBtn.adjustsImageWhenDisabled = false
        }
    }
    func pukeBtnClick(btn:UIButton){
    if priceXz ==  0 {
        self.showMessage(message: "您还未下注")
        return
    }
      
    let model = pukeNumbers[btn.tag % 1000].copy() as! GameModel
    if model.ischoose == true{
            return
        }
        
        model.ischoose = true
 
    let imageName =  model.pukenumber
    UIView.beginAnimations("animation", context: nil)
    UIView.setAnimationDelay(0.2)
    UIView.setAnimationCurve(.linear)
    UIView.setAnimationTransition(.flipFromLeft, for: btn, cache: false)
    UIView.commitAnimations()
    UIView.animate(withDuration: 0.2, animations: { 
        btn.setImage(UIImage(named: imageName!), for: .normal)
    })
    /**
     *  闲家翻牌
     */
    if btn.tag % 1000 > 4{
        throughTheArrayToSeeWhetherFlop()
    }
        
}
    /**
     判断扑克数字
     
     - parameter puck: 扑克
     
     - returns: 返回值
     */
    func getPukeNumber(puck:String)->String {
        if Int(puck)! % puckN >= 10 || Int(puck)! % puckN == 0 {
        return "10"
        }
        return "\(Int(puck)! % puckN)"
    }


    //遍历数组查看是否翻牌
    func throughTheArrayToSeeWhetherFlop(){
    var unChooses = Array<GameModel>()
     pukeNumbers.enumerated().forEach { (index,model) in
        if index > 4 && !model.ischoose{
        unChooses.append(model)
        }
     }
        if unChooses.count == 0 {
        pukeArray.enumerated().forEach({ (index,btn) in
            if index < 5{
              self.pukeBtnClick(btn: btn)
            }
        })
       endResult()
        }
    
    }
    /**
     获取最终结果
     */
    func endResult(){
        var zhuanArray = Array<String>()
        var xianArray = Array<String>()
        pukeNumbers.enumerated().forEach({ (index, model) in
            if index < 5 {
                
               zhuanArray.append(self.getPukeNumber(puck: model.pukenumber))
            }else{
                xianArray.append(self.getPukeNumber(puck: model.pukenumber))
            }
        })
        zhuanSum = self.niuniuResult(numbers: zhuanArray)
        xianSum = self.niuniuResult(numbers: xianArray)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.result == true {
            self.priceSum += self.priceXz * 2
            }
             self.addFgView(force: true)
        }
        timer.invalidate()
    }
    
    @IBOutlet weak var priceLable: UILabel!
/// 总下注数
    var priceSum:Int = 0 {
        didSet{
        priceLable.text = "余额$\(priceSum)"
        }
    }
/// 中间砝码10
    @IBOutlet weak var fmBtn100: UIButton!{
        didSet{
        fmBtn100.isUserInteractionEnabled = false
        }
    }
/// 中间砝码50
    @IBOutlet weak var fmBtn50: UIButton!{
        didSet{
            fmBtn50.isUserInteractionEnabled = false
        }
    }
/// 中间砝码100
    @IBOutlet weak var fmBtn10: UIButton!{
        didSet{
            fmBtn10.isUserInteractionEnabled = false
        }
    }
/// 下部砝码100事件
    @IBAction func price100Click(_ sender: Any) {
        if 0 > priceSum - 100 {
            self.showMessage(message: "您的筹码不足")
            return
        }
        let imageView100 = UIImageView(frame: (sender as! UIButton).frame)
        imageView100.image = UIImage(named: "icon_100")
        self.view.addSubview(imageView100)
        UIView.animate(withDuration: 0.6, delay: 0, options: .beginFromCurrentState, animations: {
            imageView100.frame = self.fmBtn100.frame
        }) { (finish) in
            self.fmBtn100.alpha = 1
            self.priceSum -= 100
            self.priceXz += 100
            self.fmBtn100.bringSubview(toFront: self.view)
            imageView100.removeFromSuperview()
        }
        
    }
/// 下部砝码50事件
    @IBAction func price50Click(_ sender: Any) {
        if 0 > priceSum - 50 {
            self.showMessage(message: "您的筹码不足")
            return
        }
        let imageView50 = UIImageView(frame: (sender as! UIButton).frame)
        imageView50.image = UIImage(named: "icon_50")
        self.view.addSubview(imageView50)
        UIView.animate(withDuration: 0.6, delay: 0, options: .beginFromCurrentState, animations: {
            imageView50.frame = self.fmBtn50.frame
        }) { (finish) in
            self.fmBtn50.alpha = 1
            self.priceSum -= 50
            self.priceXz += 50
            self.fmBtn50.bringSubview(toFront: self.view)
            imageView50.removeFromSuperview()
        }
        
    }
/// 下部砝码10事件
    @IBAction func price10Click(_ sender: Any) {
        if 0 > priceSum - 10 {
        self.showMessage(message: "您的筹码不足")
           return
        }
      let imageView10 = UIImageView(frame: (sender as! UIButton).frame)
      imageView10.image = UIImage(named: "icon_10")
      self.view.addSubview(imageView10)
      UIView.animate(withDuration: 0.6, delay: 0, options: .beginFromCurrentState, animations: { 
      imageView10.frame = self.fmBtn10.frame
      }) { (finish) in
        self.fmBtn10.alpha = 1
        self.priceSum -= 10
        self.priceXz += 10
        self.fmBtn10.bringSubview(toFront: self.view)
        imageView10.removeFromSuperview()
      }
        
    }
/// 背景图片
    @IBOutlet weak var backImage: UIImageView!{
        didSet{
        let image = backImage.image?.resizableImage(withCapInsets: UIEdgeInsets(top: 284, left: 0, bottom: 170, right: 0), resizingMode: .stretch)
         backImage.image = image
            
        }
    }
///// top图片
//    @IBOutlet weak var shangImage: UIImageView!{
//        didSet{
//        let images = [UIImage(named: "shang_1")!,UIImage(named: "shang_2")!,UIImage(named: "shang_3")!,UIImage(named: "shang_4")!,UIImage(named: "shang_5")!]
//        shangImage.animationImages = images
//        shangImage.animationDuration = 0.6
//        shangImage.animationRepeatCount = 0
//        shangImage.startAnimating()
//        }
//    }
    var timer: Timer!
    @IBOutlet weak var zhuanLable: UILabel! {
        didSet{
       
        zhuanLable.backgroundColor = UIColor.black
        zhuanLable.layer.cornerRadius = 4
        zhuanLable.layer.borderWidth = 1
        zhuanLable.layer.borderColor = UIColor.white.cgColor
        zhuanLable.layer.shadowOffset = CGSize(width: 1, height: 1)
        zhuanLable.layer.shadowRadius = 10
        zhuanLable.layer.masksToBounds = true
        
        }
    }
    @IBOutlet weak var xianLable: UILabel! {
        didSet{
        
                xianLable.backgroundColor = UIColor.black
                xianLable.layer.cornerRadius = 4
                xianLable.layer.borderWidth = 1
                xianLable.layer.borderColor = UIColor.white.cgColor
                xianLable.layer.shadowOffset = CGSize(width: 1, height: 1)
                xianLable.layer.shadowRadius = 10
                xianLable.layer.masksToBounds = true
            
        }
    }
    override func viewDidLoad() {
      super.viewDidLoad()
      setUI()
      self.setTransparentNavBar(flag: true)
      self.setNavLeftButton(image: UIImage(named: "back")!)
      self.leftButtonClicked = {btn in
       _ = self.navigationController?.popViewController(animated: true)
        }
      let userDefa = UserDefaults.standard
       priceSum = userDefa.value(forKey: "userCode") as? Int ?? 0
       userDefa.synchronize()
       addFgView(force: false)
        // Do any additional setup after loading the view.
    }
    /**
     覆盖图
     
     - parameter force:是否添加shui
     */
    func addFgView(force:Bool = false){
        timeLable.text = "30"
        fgView = FgView()
        fgView?.result = result
        fgView?.isforce = force
        fgView?.beginBtnBlock = {
        self.beginGameClick()
        self.fgView?.removeFromSuperview()
        self.setDataNumber()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timrClick), userInfo: nil, repeats: true)
            
        }
        self.view.addSubview(fgView!)
       fgView! <- [
       Edges(0)
        ]
    }
    /**
     计数器
     */
    func timrClick(){
    var number = Int(timeLable.text!) ?? 0
        if number == 0 {
       if priceXz == 0 {
        number = 30
        timeLable.text = "\(number)"
        return
        }
        changeAllBtnClick(changeAllBtn)
        timer.invalidate()
        return
        }
        number -= 1
        timeLable.text = "\(number)"
    
    }
    /**
     清空数据
     */
    func setUI(){
    fmBtn10.alpha = 0
    fmBtn50.alpha = 0
    fmBtn100.alpha = 0
    zhuanOne.alpha = 0
    zhuanTwo.alpha = 0
    zhuanThree.alpha = 0
    xianOne.alpha = 0
    xianTwo.alpha = 0
    xianThree.alpha = 0
    xianFour.alpha = 0
    xianFive.alpha = 0
    zhuanFour.alpha = 0
    zhuanFive.alpha = 0
    zhuanLable.alpha = 0
    xianLable.alpha = 0
    for btn in pukeArray {
        btn.setImage(UIImage.init(named: "pukeback"), for: .normal)
    }
    priceXz = 0
    
    }
    func setDataNumber(){
        setUI()
        pukeNumbers.removeAll()
        let array = randomModel.default.setRandomfrom(fromNumber: 1, toNumber: 52, red: 10)!
        for str in array {
            let model = GameModel()
            model.ischoose = false
            model.pukenumber = str
            pukeNumbers.append(model)
        }
        
    }
    
    /**
     开始游戏
     */
    func beginGameClick(){
        setDataNumber()
        var count:Double = 0
        pukeArray.enumerated().forEach { (index,btn) in
            let imageView = UIImageView(frame: CGRect(x: 0, y: self.view.height/2, w: 0, h: 0))
            imageView.image = UIImage(named: "pukeback")
            self.view.addSubview(imageView)
            UIView.animate(withDuration: 0.2, delay: count , options: .beginFromCurrentState, animations: {
                imageView.frame = (btn.frame)
            }) { (finish) in
                btn.alpha = 1
                imageView.removeFromSuperview()
                
            }
            count += 0.3

        }
       
    }
    /**
     牛牛算法
     
     - parameter numbers: 扑克数组
     
     - returns: 结果
     */
    func niuniuResult(numbers:Array<String>)-> Int{
        var a = 0
        var b = 0
        var c = 0
        var sum = 0
        var aArray = numbers
        var bArray = Array<String>()
        var cArrray = Array<String>()
        for astr in numbers {
            aArray = numbers
            a = Int(astr)!
            aArray.removeObject(object: astr)
            bArray = aArray
            for bstr in bArray {
                bArray = aArray
                b = Int(bstr)!
                bArray.removeObject(object: bstr)
                cArrray = bArray
                for cstr in cArrray {
                    cArrray = bArray
                    c = Int(cstr)!
                    cArrray.removeObject(object: cstr)
                    sum = a + b + c
                    if sum % 10 == 0 {
                        var result = 0
                        cArrray.enumerated().forEach({ (index, dstr) in
                            result += Int(dstr)!
                        })
                        return result
                    }
                }
            }
        }
        return 0
    }
    func numberChangeString(result:Int)-> String{
        if result == 0 {
        return "没牛"
        }
        switch result % 10 {
        case 0:
            return "牛牛"
        case 1:
            return "牛一"
        case 2:
            return "牛二"
        case 3:
            return "牛三"
        case 4:
            return "牛四"
        case 5:
            return "牛五"
        case 6:
            return "牛六"
        case 7:
            return "牛七"
        case 8:
            return "牛八"
        default:
            return "牛九"
        }

    }

    
    override func loadView() {
        Bundle.main.loadNibNamed("GameViewController", owner: self, options: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func delete(_ sender: Any?) {
        super.delete(sender)
        timer.invalidate()
        timer = nil
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
