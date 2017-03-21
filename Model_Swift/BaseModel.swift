//
//  BaseModel.swift
//  Model_Swift
//
//  Created by King on 17/3/9.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation
import Alamofire

class BaseModel : NSObject {
    
    var url : String?
    
    var method : HTTPMethod = HTTPMethod.get
}
