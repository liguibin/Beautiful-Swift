//
//  RequestModel.swift
//  Model_Swift
//
//  Created by King on 17/3/9.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation

struct RequestModel: Request {
    
    internal var urlPath: String
    
    var privateHost: String? {
        return nil
    }
    
    var HTTPMethod: ModelHTTPMethod {
        return .post
    }
    
    var timeoutInterval: TimeInterval {
        return 20.0
    }
    
    var parameter: [String : Any]? {
        return nil
    }
    
    typealias Response = TestResult
}
