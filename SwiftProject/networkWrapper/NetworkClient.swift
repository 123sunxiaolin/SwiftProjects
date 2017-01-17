//
//  NetworkClient.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/17.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

import Alamofire 
import ObjectMapper
class NetworkClient: NSObject {

    let headers: HTTPHeaders = [
        "Accept": "text/plain"
    ]
    
    func request(with request: RequestWrapper) -> Void {
        //var aClass = request.responseClass()
        
        /*let completionHandler: @escaping (DataResponse<AnyClass.Type>) -> Void = { (DataResponse<aClass>) -> Void in
            
            
        }
        
        let urlString = request.path()
        
        switch request.httpMethod {
        case HTTPMethod.Get:
            Alamofire.request(urlString!).responseObject(completionHandler: completionHandler)
        
        case HTTPMethod.Post:
            return
        default:
            return
        }*/
        
    }
}
