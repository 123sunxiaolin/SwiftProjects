//
//  String.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/20.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import Foundation

extension String{
    
    static func dateStringFromTimeStamp(timeStamp: Int) -> String {
        
        let timeInterval = TimeInterval(timeStamp/1000)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return "\(formatter.string(from: date as Date))"
    }
    
}
