//
//  SelectPreferenceViewController.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/19.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

class SelectPreferenceViewController: UIViewController, MDCSwipeToChooseDelegate{
    var CD = ConnectionDB()
    let priorityProcessingSignUp = "priorityProcessingSignUp"
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func btn(sender: AnyObject) {
        println("\(sendType)")
        appDelegate.faceType = sendType
        CD.sign_up()
    }
    
    var swipeCount: Int = 0
    
    var girlsImageArray = [
        UIImage(named: "no1.jpg")!,UIImage(named: "no2.jpg")!,
        UIImage(named: "no3.jpg")!,UIImage(named: "no4.jpg")!,
        UIImage(named: "no5.jpg")!,
    ]
    var girlsTypeArray = [8,11,2,12,12]
    var sendType: [Int] = []

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

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
            var imageURL = CD.recomendImage()
            
            let swipeView1 = createURLSwipeView(imageURL[0])
            self.view.addSubview(swipeView1)
            
            let swipeView2 = createURLSwipeView(imageURL[1])
            self.view.insertSubview(swipeView2, belowSubview: swipeView1)
            
            let swipeView3 = createURLSwipeView(imageURL[2])
            self.view.insertSubview(swipeView3, belowSubview: swipeView2)
            
            let swipeView4 = createURLSwipeView(imageURL[3])
            self.view.insertSubview(swipeView4, belowSubview: swipeView3)
            
            let swipeView5 = createURLSwipeView(imageURL[4])
            self.view.insertSubview(swipeView5, belowSubview: swipeView4)
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
    func createURLSwipeView(url: String) -> UIView {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Like"
        options.likedColor = UIColor.greenColor()
        options.nopeText = "Later"
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
        let imageURL = NSURL(string: url)
        swipeView.imageView.image = UIImage(data: NSData(contentsOfURL: imageURL!)!)
        
        return swipeView
    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection) {
        if (direction == MDCSwipeDirection.Left) {
            println("No")
        } else {
            println("Yes")
            println("\(swipeCount)")
            sendType.append(girlsTypeArray[swipeCount])
            
        }
        swipeCount++
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

