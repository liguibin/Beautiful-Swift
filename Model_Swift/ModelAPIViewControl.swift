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
    
    public func reload() {
        sendData()
    }
}

extension ModelAPIViewControl {
    
    public func getBaseModel() -> BaseModel? {
        return nil
    }
    
    func sendData() {
        let params = getBaseModel()
        
        let request = Request()
        
        request.send(params: params!, success: { response in
            
            print(response)
//            response["d"]["lesson"]
            
        }, failture: { error in
            
            print(error)
        })
    }
}
