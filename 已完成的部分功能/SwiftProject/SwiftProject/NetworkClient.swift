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
    
    func test() {
            }
    
    func request(with request: RequestWrapper) -> Void {
        //let responseClass = request.responseClass()
        
       /* Alamofire.request("123").responseObject { (DataResponse<request.responseClass() as! ResponseBean>) in
            
        }*/

        
        let successHandler = { (reponse: String) -> Void in
            
        }
        
        let failureHandler = {(error: Error) -> Void in
            request.onResponseFail(error: error)
        }
        
        let urlString = request.path()
        
        switch request.httpMethod {
        case HTTPMethod.Get:
            Alamofire.request(urlString!).responseJSON { (response) in
                switch response.result{
                case .success(_):
                    guard let value = response.result.value as? [String: Any] else{
                        return
                    }
                     let json = JSON(value)
                    successHandler(json.rawString()!)
                   
                    print(json)
                    
                case .failure(let error):
                    failureHandler(error)
                    print("error:\(error)")
                }
            }
        
        case HTTPMethod.Post:
            return
        default:
            return
        }
        
    }
}
