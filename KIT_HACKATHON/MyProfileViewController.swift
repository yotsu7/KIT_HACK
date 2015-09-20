//
//  MyProfileViewController.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/20.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    var CD = ConnectionDB()
    var myProfileArray: [String] = []
    var profileTitleArray: [String] = ["氏名: ","生年月日: ","住所: ","趣味: ","性別: "]

    var profileLabel: [UILabel]    = []
    var editBtn = UIButton(frame: CGRectMake(0, 0, 200, 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        var myProfile = CD.getMyProfileData()
        
        myProfileArray.append(myProfile["name"].toString())
        myProfileArray.append(myProfile["birthdate"].toString())
        myProfileArray.append(myProfile["address"].toString())
        myProfileArray.append(myProfile["hobby"].toString())
        
        if myProfile["gender"].toString() == "0"{
            myProfileArray.append("男性")
        }else{
            myProfileArray.append("女性")
        }
        println("\(myProfileArray)")
        
        var url = NSURL(string: myProfile["avatar"].toString())
        var err: NSError?;
        var imageData :NSData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!;
        var img = UIImage(data: imageData);
        let iv: UIImageView = UIImageView(image:img);
        iv.frame = CGRectMake(0, 0, 120, 120);
        iv.layer.position = CGPoint(x: self.view.bounds.width / 2 - 120,y: self.view.bounds.height / 2 - 250)
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 60.0
        self.view.addSubview(iv);
        
        setProfileText()
        
        editBtn.setTitle("編集画面",forState: UIControlState.Normal)
        editBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        editBtn.backgroundColor     = UIColor.whiteColor()
        editBtn.layer.masksToBounds = true
        editBtn.layer.position      = CGPoint(x: self.view.bounds.width / 2 + 120, y: self.view.bounds.height / 2 - 250)
        editBtn.addTarget(self, action: "onClickEditBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(editBtn)

        
        
    }
    func setProfileText(){
        for i in 0..<profileTitleArray.count{
            
            profileLabel.insert(UILabel(), atIndex: i)
            profileLabel[i]                = UILabel(frame: CGRectMake(0, 0, 300, 50))
            profileLabel[i].text           = profileTitleArray[i] + myProfileArray[i]
            profileLabel[i].textColor      = UIColor.blackColor()
            profileLabel[i].layer.position = CGPoint(x: self.view.bounds.width / 2 - 30,y: self.view.bounds.height / 2 - 150 + CGFloat(i * 50))
            self.view.addSubview(profileLabel[i])
            
        }
    }
    
    internal func onClickEditBtn(sender: UIButton){
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.accessFlg = true
//        let mySecondViewController: UIViewController = SelectPreferenceViewController()
        let mySecondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("selectPreference") as! UIViewController
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
//        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "selectPreference" )
//        self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
