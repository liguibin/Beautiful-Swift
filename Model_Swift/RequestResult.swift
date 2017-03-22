//
//  RequestResult.swift
//  Model_Swift
//
//  Created by King on 17/3/22.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation

struct RequestResult {
    var origin: String
}

extension RequestResult: Decodable {
    static func parse(data: Data) -> RequestResult? {
        do {
            let dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            guard let dict = dic as? Dictionary<String, Any> else {
                return nil
            }
            return RequestResult(origin: dict["d"] as! String)
        }catch {
            return nil
        }
    }
}
