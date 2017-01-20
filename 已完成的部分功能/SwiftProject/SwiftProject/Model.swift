//
//  Model.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/16.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

import ObjectMapper

class Model: Mappable {

    var id: Int?
    var keywords: String?
    var name: String?
    var seq: Int?
    var title: String?
    var description: String?
    
    init() {
        
    }
    
   required init?(map: Map) {
    
    }
    
}

extension Model{
    func mapping(map: Map) {
        id        <- map["id"]
        keywords  <- map["keywords"]
        name      <- map["name"]
        seq       <- map["seq"]
        title     <- map["title"]
        description     <- map["description"]
    }
}


class Subject: Mappable {
    var status: Bool?
    var tngou: [Model]?
    
    required init?(map: Map) {
        
    }
}

extension Subject{
    func mapping(map: Map) {
        status        <- map["status"]
        tngou         <- map["tngou"]
    }
}
