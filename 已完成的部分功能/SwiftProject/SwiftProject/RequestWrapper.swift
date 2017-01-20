//
//  RequestWrapper.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/17.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class RequestWrapper: NSObject {

    typealias SuccessHandler =  (_ request: RequestBean, _ response: ResponseBean) -> Void
    typealias FailureHandler =  (_ request: RequestBean, _ error: Error) -> Void
    
    private var bean: RequestBean!
    private var successHandler: SuccessHandler!
    private var failureHandler: FailureHandler!
    
    public var httpMethod = HTTPMethod.Get
    
    
    init(_ bean: RequestBean, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        super.init()
        self.bean = bean
        self.successHandler = success
        self.failureHandler = failure
    }
    
    public func path() ->String?{
        return self.bean.path()
    }
    
    public func parameters() ->Dictionary<String, Any>?{
        return self.bean.parameters()
    }
    
    public func responseClass() ->ResponseBean{
        return self.bean.responseClass() as! ResponseBean
    }
    
    public func onResponseFail(error: Error){
        self.failureHandler(self.bean, error)
    }
    
    func onResponseSucces(with resp: ResponseBean) {
        self.successHandler(self.bean, resp)
    }
    
    public func onResponseSuccess(response: String){
        
        var responseClass = self.bean.responseClass() as! ResponseBean
        responseClass = ResponseBean(JSONString: response)!
        onResponseSucces(with: responseClass)
        
        
    }
    
}
