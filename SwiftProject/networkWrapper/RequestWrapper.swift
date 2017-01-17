//
//  RequestWrapper.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/17.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit
import Alamofire

class RequestWrapper: NSObject {

    typealias SuccessHandler = (request: RequestBean, response: ResponseBean)
    typealias FailureHandler = (request: RequestBean, error: Error)
    
    private var bean: RequestBean?
    private var successHandler: SuccessHandler?
    private var failureHandler: FailureHandler?
    
    public var httpMethod = HTTPMethod.Get
    
    
    init(_ bean: RequestBean, success: SuccessHandler, failure: FailureHandler) {
        super.init()
        self.bean = bean
        self.successHandler = success
        self.failureHandler = failure
    }
    
    public func path() ->String?{
        return self.bean?.path()
    }
    
    public func parameters() ->Dictionary<String, Any>?{
        return self.bean?.parameters()
    }
    
    public func responseClass() ->AnyClass?{
        return self.bean?.responseClass()
    }
    
}
