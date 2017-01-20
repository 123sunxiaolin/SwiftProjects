//
//  Book.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/17.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit
import ObjectMapper

class Book: Mappable {
    
    /// ID编码
    var id: CLong?
    /// 名字
    var name: String?
    var author: String?
    var summary: String?
    var img: String!
    var bookclass: Int? //fenlei
    var count: Int? //fangwenshu
    var rcount: Int? //pinglunshu
    var fcount: Int? //shoucangshu
    var time: CLong? //time
    
    
   required init?(map: Map) {
    
    
    
    }
}

extension Book{
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
        
        img = String("http://tnfs.tngou.net/image" + img)
    }
}

class BookList: Mappable {
    
    var list: [Book]?
    var page: Int?
    var size: Int?
    var status: Bool?
    var total: Int?
    var totalpage: Int?
    
    required init?(map: Map) {
        
    }
}

extension BookList{
     func mapping(map: Map) {
        list       <- map["list"]
        page       <- map["page"]
        size       <- map["size"]
        status     <- map["status"]
        total      <- map["total"]
        totalpage  <- map["totalpage"]
    }
}

class RequestBook: Mappable {
    
    var id: Int?
    var page: Int?
    var rows: Int?
    
    init() {
        
    }
    
   required init?(map: Map) {
        
    }
    
    func path() -> String {
        return "http://www.tngou.net/api/book/list"
    }
}

extension RequestBook{
    func mapping(map: Map) {
        
        id   <- map["id"]
        page <- map["page"]
        rows <- map["rows"]
    }
}






