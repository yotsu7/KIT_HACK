//
//  ConectionDB.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/20.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit
import Alamofire
class ConnectionDB{
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var url = "http://153.120.166.12"
    
    func recomendImage() -> [String]{
        var api = JSON(url: "\(self.url)/face_selections/0.json")
        var girlsImageArray: [String] = []
        println("\(api.length)")
        
        for index in 0..<5 {
            girlsImageArray.append(api[index]["file_name"].toString())
        }
        return girlsImageArray
    }
    
    func sign_up () {
        var my_number = appDelegate.myNumber!
        
        var preference_faces = [NSDictionary]()
        for face_type in appDelegate.faceType! {
            preference_faces.append(["face_type_id": String(face_type)])
        }
        
        println(preference_faces)
        
        let parameters = [
            "user": [
                "my_number": my_number,
                "name": "村上優太",
                "birthdate": "1993-05-11",
                "address": "石川県野々市市",
                "avatar": "http://girlschannel.net/post_img/2013/01/gFLq2ipbIOOiFr1_kExIH_78.jpeg",
                "hobby": "サッカー",
                "gender": "0",
                "face_type_id": "1",
                "preference_faces_attributes": [
                    preference_faces
                ],
                "crime_histories_attributes": [
                    ["crime_name": "万引き", "crimed_at": "2015-01-01"],
                ],
                "medical_histories_attributes": [
                    ["disease_name": "風邪", "joined_at": "2012-05-05", "quited_at": "2013-01-01"],
                ],
                "work_experiences_attributes": [
                    ["company_name": "金沢工業大学", "joined_at": "1455-12-14", "quited_at": "1983-11-10"],
                ],
                "educational_backgrounds_attributes": [
                    ["school_name": "金沢工業大学", "joined_at": "1433-12-12", "quited_at": "1444-04-04"],
                ],
            ]
        ]
        
        
        let priorityProcessing = "priorityProcessing"
        let ns = NSNotificationCenter.defaultCenter()
        
        Alamofire
            .request(.POST, "http://153.120.166.12/users.json", parameters: parameters)
            .responseJSON { (request, response, data, error) in
                var json = JSON(data!)
                if json["status"].toString() == "created" {
                    self.appDelegate.accessToken = json["access_token"].toString()
                    
                    ns.postNotificationName(priorityProcessing, object: nil)
                }
        }
    }
    
    func sign_in (my_number: String) {
        let parameters = ["my_number": my_number]
        let priorityProcessing = "priorityProcessing"
        let ns = NSNotificationCenter.defaultCenter()
        
        Alamofire
            .request(.POST, "http://153.120.166.12/user_sessions.json", parameters: parameters)
            .responseJSON { (request, response, data, error) in
                var json = JSON(data!)
                if json["status"].toString() == "ok" {
                    self.appDelegate.accessToken = json["access_token"].toString()
                    
                    ns.postNotificationName(priorityProcessing, object: nil)
                }
        }
    }
    
    func recommendedUsers() -> JSON {
        var accessToken = appDelegate.accessToken!
        println("\(accessToken)")
        var users = JSON(url: "\(self.url)/recommended_users.json?access_token=\(accessToken)")

        return users
    }
    
    func getMyProfileData() -> JSON{
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var accessToken = appDelegate.accessToken!
        var myNumber    = appDelegate.myNumber!
        println("myNumber: \(myNumber)")
        var userData    = JSON(url: "\(self.url)/users/0.json?access_token=\(accessToken)&my_number=1\(myNumber)")
        
        return userData
    }

    func sendRequest(receiver_id: String) {
        let accessToken = appDelegate.accessToken!
        let parameters = ["access_token": accessToken, "receiver_id": receiver_id, "message": "リクエスト承認お願いします"]
        
        Alamofire
            .request(.POST, "\(self.url)/requests.json", parameters: parameters)
            .responseJSON { (_, _, data, error) in
                var json = JSON(data!)
                println(json)
                
                if json["status"].toString() == "created" {
                    let myAlert: UIAlertController = UIAlertController(title: "リクエスト送信", message: "リクエストを送信しました。相手から承認されるまでお待ち下さい。", preferredStyle: .Alert)
                    
                    let myOkAction = UIAlertAction(title: "閉じる", style: .Default) { action in
                        println("close")
                    }
                    myAlert.addAction(myOkAction)
                    
                    var view = self.appDelegate.window!.rootViewController
                    view!.presentViewController(myAlert, animated: true, completion: nil)
                }
        }
    }
    
}
