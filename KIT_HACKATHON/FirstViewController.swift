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
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var CD = ConnectionDB()
        
        var recommendedUsers = CD.recommendedUsers()
        
        println(recommendedUsers[0]["avatar"])
        
        for var i = 0; i < recommendedUsers.length; i++ {
            var url = NSURL(string: recommendedUsers[i]["avatar"].toString());
            var err: NSError?;
            var imageData :NSData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!;
            var img = UIImage(data: imageData);
            let iv: UIImageView = UIImageView(image:img);
            iv.frame = CGRectMake(0, 0, 120, 120);
            iv.layer.masksToBounds = true
            iv.layer.cornerRadius = 60.0
            self.view.addSubview(iv);
            
            var yPosition = 120.0 + 180.0 * CGFloat(i)
            
            iv.layer.position = CGPoint(x: self.view.bounds.width / 5, y: yPosition)
            
            let label: UILabel = UILabel(frame: CGRectMake(0,0,200,120))
            label.backgroundColor = UIColor.magentaColor()
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10.0
            label.layer.position = CGPoint(x: self.view.bounds.width/2 + 80, y: yPosition)
            self.view.addSubview(label)
            
            let name: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
            name.text = recommendedUsers[i]["name"].toString()
            name.textColor = UIColor.whiteColor()
            name.layer.position = CGPoint(x: self.view.bounds.width/2 + 100, y: yPosition - 30.0)
            self.view.addSubview(name)
            
            let job: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
            job.text = recommendedUsers[i]["last_work_experience"].toString()
            job.textColor = UIColor.whiteColor()
            job.layer.position = CGPoint(x: self.view.bounds.width/2 + 100, y: yPosition - 10.0)
            self.view.addSubview(job)
            
            
            let school: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
            school.text = recommendedUsers[i]["last_educational_background"].toString()
            school.textColor = UIColor.whiteColor()
            school.layer.position = CGPoint(x: self.view.bounds.width/2 + 100, y: yPosition + 10.0)
            self.view.addSubview(school)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
