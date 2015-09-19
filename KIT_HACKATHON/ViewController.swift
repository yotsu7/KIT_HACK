//
//  ViewController.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/19.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    let textfield = UITextField(frame: CGRectMake(0, 0, 200, 30))
    var myButton = UIButton(frame: CGRectMake(0,0,200,40))
    var label = UILabel(frame: CGRectMake(0, 0, 0, 0))
    var message = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        /*ラベル*/
        label.layer.position = CGPoint(x: 57, y: 159)
        //文字色
        label.textColor = UIColor.blackColor()
        //影の色
        //label.shadowColor = UIColor.grayColor()
        //文字
        label.text = "あなたのマイナンバーを入力"
        label.sizeToFit()
        //表示する
        self.view.addSubview(label)
        /*ラベル*/
        
        
        
        /*テキストフィールド*/
        
        //薄く文字を表示
        textfield.placeholder = "マイナンバーを入力"
        //テキストフィールドの場所
        textfield.layer.position = CGPoint (x: self.view.frame.width/2 , y: 200)
        //テキストフィールドの枠
        textfield.borderStyle = UITextBorderStyle.RoundedRect
        //テキストフィールドの値を保存するためのもの
        textfield.delegate = self
        //テキストフィールドを表示
        self.view.addSubview(textfield)
        /*テキストフィールド*/
        
        
        
        
        /*ボタン*/
        myButton.backgroundColor = UIColor.redColor()
        // 枠を丸くする
        myButton.layer.masksToBounds = true
        // タイトルを設定する(通常時)
        myButton.setTitle("login", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // タイトルを設定する(ボタンがハイライトされた時)
        myButton.setTitle("login", forState: UIControlState.Highlighted)
        myButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        // コーナーの半径を設定する
        myButton.layer.cornerRadius = 20.0
        // ボタンの位置を指定する
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:450)
        // イベントを追加する
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する
        self.view.addSubview(myButton)
        /*ボタン*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    テキストフィールドの入力完了時
    */
    func textFieldShouldReturn(text: UITextField) -> Bool{
        text.resignFirstResponder()
        message = text.text!
        return true
    }
    
    /*
    ボタンのアクション時に設定したメソッド.
    */
    internal func onClickMyButton(sender: UIButton){
        print(message)
    }
    

}

