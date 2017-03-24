//
//  RequestResult.swift
//  Model_Swift
//
//  Created by King on 17/3/22.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation
import ObjectMapper


public struct DictionaryTransform<Key, Value>: TransformType where Key: Hashable, Key: RawRepresentable, Key.RawValue == String, Value: Mappable {
    
    public init() {
        
    }
    
    public func transformFromJSON(_ value: Any?) -> [Key: Value]? {
        
        guard let json = value as? [String: Any] else {
            
            return nil
        }
        
        guard (value as? Any) != nil else {
            
            return nil
        }
        
        let result = json.reduce([:]) { (result, element) -> [Key: Value] in
            
            guard
                let key = Key(rawValue: element.0),
                let valueJSON = element.1 as? [String: Any],
                let value = Value(JSON: valueJSON)
                else {
                    
                    return result
            }
            
            var result = result
            result[key] = value
            return result
        }
        
        return result
    }
    
    public func transformToJSON(_ value: [Key: Value]?) -> Any? {
        
        let result = value?.reduce([:]) { (result, element) -> [String: Any] in
            
            let key = element.0.rawValue
            let value = element.1.toJSON()
            
            var result = result
            result[key] = value
            return result
        }
        
        return result
    }
}

protocol Decodable {
    static func parse(json: Any) -> Self?
}

struct TestResult {
    var result: ResultMap
}

extension TestResult: Decodable {
    static func parse(json: Any) -> TestResult? {
        do {
            let dic = Mapper<ResultMap>().map(JSONObject: json)
            
            return TestResult(result: dic!)

            //guard let dic != nil else {
              //  return nil
            //}
        }catch {
            return nil
        }
    }
}

class ResultMap: Mappable {
    
    var c: Int = 0
    var d: [Mykey: MyValue] = [:]
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        c <- map["c"]
        d <- (map["d"], DictionaryTransform<Mykey, MyValue>())
        
    }
}

extension ResultMap {
    enum Mykey: String {
        case banner = "banner"
        case mentor = "mentor"
        case lastLesson = "lastLesson"
        case lesson = "lesson"
    }
}

extension ResultMap {
    class MyValue: Mappable {
        
        var value: Any?
        
        required init?(map: Map) {
            
            self.mapping(map: map)
            
        }
        
        func mapping(map: Map) {
            self.value <- map["valuue"]
        }
    }
}


