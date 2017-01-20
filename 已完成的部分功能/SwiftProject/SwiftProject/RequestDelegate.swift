//
//  RequestDelegate.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/17.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol RequestDelegate{
    
    func path() -> String?
    func parameters() -> Dictionary<String, Any>?
    func responseClass() -> BaseMappable
    
}
