//
//  Decodable.swift
//  Model_Swift
//
//  Created by King on 17/3/22.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation

protocol Decodable {
    static func parse(data: Data) -> Self?
}
