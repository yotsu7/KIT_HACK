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
//                    self.access_token = json["access_token"].toString()
//                    println(self.access_token!)
                }
        }
    }
    
    func recommendedUsers() -> JSON {
//        var accessToken = "22b47d8ca6970e1d4f5d30b8ab3aa072"
        var accessToken = appDelegate.accessToken!
        var users = JSON(url: "\(self.url)/recommended_users.json?access_token=\(accessToken)")

        return users
    }
    
}
