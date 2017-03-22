//
//  Request.swift
//  Model_Swift
//
//  Created by King on 17/3/20.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation

public enum ModelHTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
    
}

protocol Request {
    
    var urlPath: String { set get }
    var privateHost: String? { get }
    var HTTPMethod: ModelHTTPMethod { get }
    var timeoutInterval: TimeInterval { get }
    var parameter: [String: Any]? { get }
    
    associatedtype Response: Decodable
}
