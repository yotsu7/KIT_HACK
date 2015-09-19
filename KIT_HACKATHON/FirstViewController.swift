//
//  FirstViewController.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/19.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var CD = ConnectionDB()
        
        // Viewの背景色をCyanに設定する.
        self.view.backgroundColor = UIColor.cyanColor()
        
        var recommendedUsers = CD.recommendedUsers()
        
        println(recommendedUsers[0]["avatar"])
        
//        for user in recommendedUsers {
//            let url = NSURL(string: user["avatar"]);
//            var err: NSError?;
//            var imageData :NSData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!;
//            var img = UIImage(data: imageData);
//            let iv: UIImageView = UIImageView(image:img);
//            iv.frame = CGRectMake(0, 0, 120, 120);
//            self.view.addSubview(iv);
//            iv.layer.position = CGPoint(x: self.view.bounds.width/2, y: 200.0)
////            CGPoint(x: 20, y: 50 + (100 * i))
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
