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
    
    private var recommendedUsers: JSON?
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var CD = ConnectionDB()
        
        recommendedUsers = CD.recommendedUsers()
        
        println(self.recommendedUsers![0]["avatar"])
        
        for var i = 0; i < self.recommendedUsers!.length; i++ {
            var url = NSURL(string: recommendedUsers![i]["avatar"].toString());
            var err: NSError?;
            var imageData :NSData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!;
            var img = UIImage(data: imageData);
            let iv: UIImageView = UIImageView(image:img);
            iv.frame = CGRectMake(0, 0, 100, 100);
            iv.layer.masksToBounds = true
            iv.layer.cornerRadius = 50.0
            iv.userInteractionEnabled = true
            iv.contentMode = UIViewContentMode.ScaleAspectFill
            iv.tag = i + 1
            self.view.addSubview(iv);
            
            var yPosition = 120.0 + 180.0 * CGFloat(i)
            
            iv.layer.position = CGPoint(x: self.view.bounds.width/6, y: yPosition)
            
            let label: UILabel = UILabel(frame: CGRectMake(0,0,250,120))
            label.backgroundColor = UIColor.magentaColor()
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10.0
            label.layer.position = CGPoint(x: self.view.bounds.width/6 + 180.0, y: yPosition)
            self.view.addSubview(label)
            
            let name: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
            name.text = recommendedUsers![i]["name"].toString()
            name.textColor = UIColor.whiteColor()
            name.textAlignment = NSTextAlignment.Left
            name.layer.position = CGPoint(x: label.bounds.width/2, y: label.bounds.height/2 - 30)
            label.addSubview(name)
            
            let job: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
            job.text = recommendedUsers![i]["last_work_experience"].toString()
            job.textColor = UIColor.whiteColor()
            job.textAlignment = NSTextAlignment.Left
            job.layer.position = CGPoint(x: label.bounds.width/2, y: label.bounds.height/2)
            label.addSubview(job)
            
            
            let school: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
            school.text = recommendedUsers![i]["last_educational_background"].toString()
            school.textColor = UIColor.whiteColor()
            school.textAlignment = NSTextAlignment.Left
            school.layer.position = CGPoint(x: label.bounds.width/2, y: label.bounds.height/2 + 30)
            label.addSubview(school)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        println(touch.view.tag)
        let touched_index = touch.view.tag
        
        if touched_index > 0 {
            var alertMessage = self.recommendedUsers![touched_index - 1]["name"].toString() + "さんにリクエストを送りますか？"
            let myAlert: UIAlertController = UIAlertController(title: "リクエスト送信", message: alertMessage, preferredStyle: .Alert)
            
            let myOkAction = UIAlertAction(title: "送信", style: .Default) { action in
                println("Action OK!!")
                var CD = ConnectionDB()
                var receiver_id = self.recommendedUsers![touched_index - 1]["id"].toString()
                CD.sendRequest(receiver_id)
            }
            myAlert.addAction(myOkAction)
            
            let myNoAction = UIAlertAction(title: "やめる", style: .Default) { action in
                println("Action NO")
            }
            myAlert.addAction(myNoAction)
            
            
            presentViewController(myAlert, animated: true, completion: nil)
        }
    }

}
