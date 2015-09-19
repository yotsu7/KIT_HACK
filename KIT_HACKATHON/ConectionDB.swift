//
//  ConectionDB.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/20.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit

class ConnectionDB{
    
    func recomendImage(){
        var api = JSON(url: "http://153.120.166.12/face_selections/0.json")
        println("\(api.length)")
        var x = api[1]["face_type_id"]
        var y = api[1]["file_name"]
        println("\(x)")
        println("\(y)")
    }
    
}
