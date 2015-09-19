//
//  SelectPreferenceViewController.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/19.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit

class SelectPreferenceViewController: UIViewController, MDCSwipeToChooseDelegate{
    
    var CD = ConnectionDB()
    
    var swipeCount: Int = 0
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var girlsImageArray = [
        UIImage(named: "no1.jpg")!,UIImage(named: "no2.jpg")!,
        UIImage(named: "no3.jpg")!,UIImage(named: "no4.jpg")!,
        UIImage(named: "no5.jpg")!,
    ]
    var girlsTypeArray = [8,11,2,12,12]
    var sendType: [Int] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CD.recomendImage()

        var accessFlg = appDelegate.accessFlg
        if accessFlg == nil{
            accessFlg = false
            setImage(accessFlg!)
        }else{
            //個人Profile閲覧画面からの遷移の処理
            setImage(accessFlg!)
        }
        
        
    }
    func setImage(accessFlg: Bool){
        if accessFlg{
            println("test成功")
        }else{
            for number in 0..<girlsImageArray.count{
                if number == 0 {
                    self.view.addSubview(createSwipeView(girlsImageArray[number]))
                }else{
                    self.view.insertSubview(createSwipeView(girlsImageArray[number - 1]), belowSubview: createSwipeView(girlsImageArray[number]))
                }
            }
        }
    }
    
    func createSwipeView(img: UIImage) -> UIView {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Yes"
        options.likedColor = UIColor.greenColor()
        options.nopeText = "No"
        options.nopeColor = UIColor.lightGrayColor()
        
        let swipeView = MDCSwipeToChooseView(
            frame: CGRect(
                x: 0,
                y: 100,
                width: self.view.bounds.size.width,
                height: self.view.bounds.size.height - 300
            ),
            options: options
        )
        swipeView.imageView.image = img
        
        return swipeView
    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection) {
        if (direction == MDCSwipeDirection.Left) {
            println("No")
        } else {
            println("Yes")
            println("\(swipeCount)")
            sendType.append(swipeCount)
            
        }
        swipeCount++
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

