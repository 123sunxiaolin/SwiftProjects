//
//  RequestBean.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/17.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit
import ObjectMapper


class RequestBean: NetworkBean, RequestDelegate{

    func path() -> String? {
        return nil
    }
    
    func parameters() -> Dictionary<String, Any>? {
        return self.toJSON()
    }
    
    func responseClass() -> BaseMappable {
        return ResponseBean() as BaseMappable
    }
}
