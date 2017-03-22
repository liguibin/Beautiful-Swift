//
//  Client.swift
//  Model_Swift
//
//  Created by King on 17/3/22.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation

protocol Client {
    
    var host: String { get }
    
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?, String?) -> Void);
}

