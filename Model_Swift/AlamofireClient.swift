//
//  AlamofireClient.swift
//  Model_Swift
//
//  Created by King on 17/3/22.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol Client {
    
    var host: String { get }
    
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?, String?) -> Void);
}

public struct AlamofireClient: Client {
    
    public static let `default` = { AlamofireClient() }()
    
    public enum HostType: String {
        case sandbox = "https://api.qirenqiji.com/"
    }

    /// Base host URL
    public var host: String = HostType.sandbox.rawValue
    
    func send<T : Request>(_ r: T, handler: @escaping (T.Response?, String?) -> Void) {
                
        let url = URL(string: r.privateHost ?? host.appending(r.urlPath))!
        
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.configuration.timeoutIntervalForRequest = r.timeoutInterval
        
        
        _ = Alamofire.request(url, method: HTTPMethod(rawValue: r.HTTPMethod.rawValue)!,
                          parameters: r.parameter,
                          encoding: URLEncoding.default,
                          headers: nil)
        
        .responseJSON { (response) in
            
            if let res = T.Response.parse(json:response.value!) {
                
                handler(res, nil)
                
            }else {
                
                handler(nil, response.error?.localizedDescription)
            }
        }
    }
}

