//
//  ModelAPIViewControl.swift
//  Model_Swift
//
//  Created by King on 17/3/6.
//  Copyright © 2017年 King. All rights reserved.
//

import UIKit

class ModelAPIViewControl: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var data = NSArray()
    
    open func reload() {
        sendData()
    }
    
    open func getRequestModel() -> RequestModel? {
        return RequestModel(urlPath: "")
    }
    
    func sendData() {
        let requestModel : RequestModel = getRequestModel()!
                
        AlamofireClient.default.send(requestModel) { (response, error) in
            
        }
    }
}
