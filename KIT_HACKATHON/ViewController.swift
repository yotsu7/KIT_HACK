//
//  ViewController.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/19.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    var message = ""
    var json:NSData!
    var connect = ConnectionDB()
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let signupButton: UIButton = UIButton()
    var logonButton: UIButton = UIButton()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        /*背景画像*/
        let backgroundImage = UIImage(named: "background.jpg")!
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        /*背景画像*/
        
        /*タップ*/
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        /*タップ*/
        

        
        /*テキストフィールド*/
        let textfield = UITextField(frame: CGRectMake(0, 0, 200, 30))
        //薄く文字を表示
        textfield.placeholder = "入力"
        //テキストフィールドの場所
        textfield.layer.position = CGPoint (x: self.view.frame.width/2 , y: 200)
        //テキストフィールドの枠
        textfield.borderStyle = UITextBorderStyle.RoundedRect
        //テキストフィールドの値を保存するためのもの
        textfield.delegate = self
        //テキストフィールドを表示
        textfield.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.view.addSubview(textfield)
        /*テキストフィールド*/
        
        
        
        /*ラベル*/
        var label = UILabel(frame: CGRectMake(0, 0, 250, 20))
        //フォント指定
        label.font = UIFont(name: "Zapfino",size: 16)
        //ラベルの位置
        label.layer.position = CGPoint(x: self.view.bounds.width / 2, y: view.bounds.height / 2 - 180)
        //文字
        label.text = "あなたのマイナンバーを入力"
        //文字色
        label.textColor = UIColor.blackColor()
        // 文字を中央寄せ
        label.textAlignment = NSTextAlignment.Center
        //表示する
        self.view.addSubview(label)
        /*ラベル*/
        
        
        
        /*登録ボタン*/
        signupButton.frame = CGRectMake(0, 0, 100, 30)
        signupButton.backgroundColor = UIColorFromRGB(0x2ecc71)

        // 枠を丸くする
        signupButton.layer.masksToBounds = true

        // タイトルを設定する(通常時)
        signupButton.setTitle("登録", forState: UIControlState.Normal)
        signupButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        // コーナーの半径を設定する
        signupButton.layer.cornerRadius = 5.0
        
        // ボタンの位置を指定する
        signupButton.layer.position = CGPoint(x: self.view.frame.width/2 + 60 , y:400)
        
        // イベントを追加する
        signupButton.addTarget(self, action: "onClickSignupButton:", forControlEvents: .TouchUpInside)

        // ボタンをViewに追加する
        self.view.addSubview(signupButton)

        // spinner 追加
        spinner.frame = CGRect(x: -20, y: 6, width: 20, height: 20)
        spinner.startAnimating()
        spinner.alpha = 0.0
        /*登録ボタン*/
        
        
        
        /*ログオンボタン*/
        //色を変える
        logonButton.frame = CGRectMake(0, 0, 100, 30)
        logonButton.backgroundColor = UIColor.redColor()
        // 枠を丸くする
        logonButton.layer.masksToBounds = true

        // タイトルを設定する(通常時)
        logonButton.setTitle("ログオン", forState: UIControlState.Normal)
        logonButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

        // コーナーの半径を設定する
        logonButton.layer.cornerRadius = 5.0
        // ボタンの位置を指定する
        logonButton.layer.position = CGPoint(x: self.view.frame.width/2 - 60 , y:400)
        // イベントを追加する
        logonButton.addTarget(self, action: "onClickLogonButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する
        self.view.addSubview(logonButton)
        // spinner 追加
        spinner.frame = CGRect(x: -20, y: 6, width: 20, height: 20)
        spinner.startAnimating()
        spinner.alpha = 0.0
        /*ログオンボタン*/
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
    */
    func textFieldDidBeginEditing(text: UITextField){
        message = text.text!

    }
    
    /*
    UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldEndEditing(text: UITextField) -> Bool {
        message = text.text!
        return true
    }
    /*
    テキストフィールドの入力完了時
    */
    func textFieldShouldReturn(text: UITextField) -> Bool{
        message = text.text!
        text.resignFirstResponder()
        return true
    }
    
    /*キーボード以外の場所をタップした時に呼び出される*/
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    /*
    UIcolorをRGB(16進数)で入力するためのメソッド
    */
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    
    /*
    登録ボタンのアクション時に設定したメソッド
    */
    internal func onClickSignupButton(sender: UIButton){

        //アニメーション
        let b = self.signupButton.bounds
        UIView.animateWithDuration(1.1, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: nil, animations: {
            // ボタンサイズの変更
            self.signupButton.bounds = CGRectMake(b.origin.x, b.origin.y, b.size.width + 10, b.size.height)
            // ボタンカラーの変更
            self.signupButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            // spinnerのalpha値を変更して表示
            self.spinner.alpha = 1.0
            // spinnerの位置を設定
            self.spinner.center = CGPointMake(40, self.signupButton.frame.size.height / 2)
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 0.2, usingSpringWithDamping: 0.2, initialSpringVelocity: 3, options: nil, animations: {
            // ボタンサイズを元に戻す
            self.signupButton.bounds = CGRectMake(b.origin.x, b.origin.y, b.size.width, b.size.height)
            // ボタンカラーを元に戻す
            self.signupButton.backgroundColor = self.UIColorFromRGB(0x2ecc71)
            // spinnerを非表示に
            self.spinner.alpha = 0.0
            }, completion: nil)

        
        
        //登録処理
        if message != ""{
            appDelegate.myNumber = message
            println(message)
            var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "profile" )
            self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
        }else{
            //アラート
            // UIAlertControllerを作成する.
            let myAlert: UIAlertController = UIAlertController(title: "input error", message: "please, input your 'mynumber'.", preferredStyle: .Alert)
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                println("error aleart: 入力エラー")
            }
            // OKのActionを追加する.
            myAlert.addAction(myOkAction)
            
            // UIAlertを発動する.
            presentViewController(myAlert, animated: true, completion: nil)
        }
        

    }
    
    
    
    /*
    ログオンボタンのアクション時に設定したメソッド
    */
    internal func onClickLogonButton(sender: UIButton){
        
        //アニメーション
        let b = self.logonButton.bounds
        UIView.animateWithDuration(1.1, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: nil, animations: {
            // ボタンサイズの変更
            self.logonButton.bounds = CGRectMake(b.origin.x, b.origin.y, b.size.width + 10, b.size.height)
            // ボタンカラーの変更
            self.logonButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            // spinnerのalpha値を変更して表示
            self.spinner.alpha = 1.0
            // spinnerの位置を設定
            self.spinner.center = CGPointMake(40, self.logonButton.frame.size.height / 2)
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 0.2, usingSpringWithDamping: 0.2, initialSpringVelocity: 3, options: nil, animations: {
            // ボタンサイズを元に戻す
            self.logonButton.bounds = CGRectMake(b.origin.x, b.origin.y, b.size.width, b.size.height)
            // ボタンカラーを元に戻す
            self.logonButton.backgroundColor = UIColor.redColor()
            // spinnerを非表示に
            self.spinner.alpha = 0.0
            }, completion: nil)

        
        //ログオン処理
        if message != ""{
            appDelegate.myNumber = message
            connect.sign_in(message)
        }else{

            //アラート
            // UIAlertControllerを作成する.
            let myAlert: UIAlertController = UIAlertController(title: "input error", message: "please, input your 'mynumber'.", preferredStyle: .Alert)
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                println("error aleart: 入力エラー")
            }
            // OKのActionを追加する.
            myAlert.addAction(myOkAction)
            
            // UIAlertを発動する.
            presentViewController(myAlert, animated: true, completion: nil)

        }
        
        
    }

}

