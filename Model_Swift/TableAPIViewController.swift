//
//  TableAPIViewController.swift
//  Model_Swift
//
//  Created by King on 17/3/6.
//  Copyright © 2017年 King. All rights reserved.
//

import UIKit
import Alamofire

class TableAPIViewController : ModelAPIViewControl, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createTable()
        
        self.reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var tableView = UITableView()
    
    func createTable() {
        self.tableView = UITableView(frame:CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height), style:UITableViewStyle.plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getNumberSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getNumberRow(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.getRowHeight(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return customCell()
    }
}


/**
 *  table delegate & datasource
 */
extension TableAPIViewController {
    
    public func getNumberSection() -> Int {
        return 0
    }
    
    public func getNumberRow(section: Int) -> Int {
        return 0
    }
    
    public func getRowHeight (indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    public func cellString() -> AnyClass? {
        return nil
    }
    
    func customCell() -> UITableViewCell {
        let tableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: NSStringFromClass(self.cellString()!))
        
        return tableViewCell
    }
}

extension TableAPIViewController {
    override func getBaseModel() -> BaseModel? {
        let baseModel = BaseModel()
        baseModel.url = "https://api.qirenqiji.com/home/v2"
        baseModel.method = HTTPMethod.get
        return baseModel
    }
}
