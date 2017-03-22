//
//  Request.swift
//  Model_Swift
//
//  Created by King on 17/3/20.
//  Copyright © 2017年 King. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    
    var request: Alamofire.Request? {
        didSet {
            oldValue?.cancel()
            
//            title = request?.description
//            refreshControl?.endRefreshing()
            headers.removeAll()
            body = nil
            elapsedTime = nil
        }
    }
    
    var headers: [String: String] = [:]
    var body: String?
    var elapsedTime: TimeInterval?
    var segueIdentifier: String?
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func send (params : BaseModel, success:@escaping(_ response:[String:Any]) ->(), failture:@escaping(_ error:Error) ->()) {
        self.request = Alamofire.request(params.url!, method: params.method)

        guard let request = request else {
            return
        }
        
        let requestCompleteWithJson: (HTTPURLResponse?, Result<Any>) -> Void = { response, result in
            
            if let response = response {
                for (field, value) in response.allHeaderFields {
                    self.headers["\(field)"] = "\(value)"
                }
            }
            
            if let segueIdentifier = self.segueIdentifier {
                switch segueIdentifier {
                case "GET", "POST", "PUT", "DELETE":
                    self.body = result.value as! String?
                case "DOWNLOAD":
                    self.body = self.downloadedBodyString()
                default:
                    break
                }
            }
            
//            func jsonToData(value : JSON) {
//                if value.type == SwiftyJSON.Type.dictionary {
//                    if value["c"] == 0 {
//                        success(value.object as! [String : Any])
//                    }
//                }
//            }
            
            switch result {
                
            case .success(let value):
//                jsonToData(value: JSON(value))
                break
            case .failure(let error):
                failture(error)
            }
        }
       
        
        if let request = request as? DataRequest {
            
            request.responseJSON{ response in
                requestCompleteWithJson(response.response, response.result)
            }
        }
    }
    
    private func downloadedBodyString() -> String {
        let fileManager = FileManager.default
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        
        do {
            let contents = try fileManager.contentsOfDirectory(
                at: cachesDirectory,
                includingPropertiesForKeys: nil,
                options: .skipsHiddenFiles
            )
            
            if let fileURL = contents.first, let data = try? Data(contentsOf: fileURL) {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                let prettyData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                if let prettyString = String(data: prettyData, encoding: String.Encoding.utf8) {
                    try fileManager.removeItem(at: fileURL)
                    return prettyString
                }
            }
        } catch {
            // No-op
        }
        
        return ""
    }

}
