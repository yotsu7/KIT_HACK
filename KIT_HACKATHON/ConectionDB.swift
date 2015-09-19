//
//  ConectionDB.swift
//  KIT_HACKATHON
//
//  Created by X-men on 2015/09/20.
//  Copyright (c) 2015年 TakamitsuYotsuyanagi. All rights reserved.
//

import UIKit

class ConnectionDB{
    
    func recomendImage() -> [String]{
        var api = JSON(url: "http://153.120.166.12/face_selections/0.json")
        var girlsImageArray: [String] = []
        println("\(api.length)")
        
        for index in 0..<5 {
            girlsImageArray.append(api[index]["file_name"].toString())
        }

        
        return girlsImageArray
    }
    
}
