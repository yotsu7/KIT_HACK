//
//  ProfileViewController.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/19.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate{

    private var myImageView: UIImageView!
    private var profileLabel: [UILabel]    = []
    private var hobbyTextField             = UITextField(frame: CGRectMake(0, 0, 300, 50))
    private var nextBtn                    = UIButton(frame: CGRectMake(0, 0, 200, 40))
    private var backBtn                    = UIButton(frame: CGRectMake(0, 0, 200, 40))
    private var profileTextArray: [String] = ["氏名：村上優太","性別:男","住所:富山県富山市","生年月日：1月1日","職歴：勇者","学歴：大卒","病歴：なし","犯罪歴：なし"]
    private var profileArray: [String] = ["村上優太","男","富山県富山市","1月1日","勇者","大卒","なし","なし",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageView                = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        let myImage                = UIImage(named: "faceImage.jpeg")
        myImageView.image          = myImage
        myImageView.layer.position = CGPoint(x: self.view.bounds.width / 2 - 120,y: self.view.bounds.height / 2 - 250)
        self.view.addSubview(myImageView)
        
        setProfile(profileTextArray)
        
        hobbyTextField.placeholder    = "趣味を入力してください。"
        hobbyTextField.layer.position = CGPoint(x: self.view.bounds.width / 2 + 10, y: self.view.bounds.height / 2 + 230)
        hobbyTextField.borderStyle    = UITextBorderStyle.RoundedRect
        hobbyTextField.delegate       = self
        self.view.addSubview(hobbyTextField)
        
        
        nextBtn.setTitle("次へ",forState: UIControlState.Normal)
        nextBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        nextBtn.backgroundColor     = UIColor.whiteColor()
        nextBtn.layer.masksToBounds = true
        nextBtn.layer.position      = CGPoint(x: self.view.bounds.width / 2 + 100, y: self.view.bounds.height / 2 + 280)
        nextBtn.addTarget(self, action: "onClickNextBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(nextBtn)

        backBtn.setTitle("戻る",forState: UIControlState.Normal)
        backBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        backBtn.backgroundColor     = UIColor.whiteColor()
        backBtn.layer.masksToBounds = true
        backBtn.layer.position      = CGPoint(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 + 280)
        backBtn.addTarget(self, action: "onClickBackBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(backBtn)
        
        
        
        let myTap = UITapGestureRecognizer(
            target: self, action: "tapGesture:")
        self.view.addGestureRecognizer(myTap)

        
        
        
    }
    func setProfile(profile: [String]){
        println("\(profile.count)")
        for menu in 0..<profile.count{
            profileLabel.insert(UILabel(), atIndex: menu)
            profileLabel[menu]                = UILabel(frame: CGRectMake(0, 0, 200, 50))
            profileLabel[menu].text           = profile[menu]
            profileLabel[menu].textColor      = UIColor.blackColor()
            profileLabel[menu].layer.position = CGPoint(x: self.view.bounds.width / 2 - 80,y: self.view.bounds.height / 2 - 180 + CGFloat(menu * 50))
            self.view.addSubview(profileLabel[menu])
        }
    
    }
    internal func onClickNextBtn(sender: UIButton){
        println("onClickNextBtn")
//        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "profile" )
//        self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
    }
    internal func onClickBackBtn(sender: UIButton){
        println("onClickBackBtn")
        //        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "profile" )
        //        self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
    }
    func textFieldShouldReturn(text: UITextField) -> Bool{
        text.resignFirstResponder()
        profileArray.append(text.text!)
        return true
    }
    func tapGesture(sender: UITapGestureRecognizer){
        for v in self.view.subviews {
            if(v is UITextField) {
                let txt = v as! UITextField
                if(txt.isFirstResponder()) {
                    txt.resignFirstResponder()
                    return
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
