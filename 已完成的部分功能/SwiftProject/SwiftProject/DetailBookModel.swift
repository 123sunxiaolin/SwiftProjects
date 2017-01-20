//
//  DetailBookModel.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/20.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit
import ObjectMapper

class DetailBookModel: Mappable {

    var id: Int?
    var name: String?
    var author: String?
    var summary: String?
    var img: String!
    var bookclass: Int? //fenlei
    var count: Int? //fangwenshu
    var rcount: Int? //pinglunshu
    var fcount: Int? //shoucangshu
    var time: CLong? //time
    var list: [DetailBook]?
    
    
    
   required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id         <- map["id"]
        name       <- map["name"]
        author     <- map["author"]
        summary    <- map["summary"]
        img        <- map["img"]
        bookclass  <- map["bookclass"]
        count      <- map["count"]
        rcount     <- map["rcount"]
        fcount     <- map["fcount"]
        time       <- map["time"]
        list       <- map["list"]
        
        img = String("http://tnfs.tngou.net/image" + img + "_80x120")
        
    }
}

class DetailBook: Mappable {
    
    var book: Int?
    var id: Int?
    var message: String?
    var seq: Int?
    var title: String?
    
    
   required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        
        id         <- map["id"]
        book       <- map["book"]
        message    <- map["message"]
        title      <- map["title"]
        seq        <- map["seq"]
    }
}

class RequestDetailBook: Mappable {
    var id: Int?
    
   required init?(map: Map) {
    
    }
    
    init() {
    }
    
    func Path() -> String {
        return "http://www.tngou.net/api/book/show"
    }
    
    func mapping(map: Map) {
        id         <- map["id"]
    }
}




