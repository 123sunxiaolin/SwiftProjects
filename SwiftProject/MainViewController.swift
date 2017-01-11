//
//  MainViewController.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/11.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    struct tableData {
        let funcName:String
    }
    
    let data = [
        tableData(funcName: "定时器")
    ]
    
    
    private lazy var funcListTableView : UITableView! = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK:life Cycle
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "功能列表"
        
        self.view.addSubview(self.funcListTableView)
        self.funcListTableView.snp.makeConstraints { (make)->Void in
            make.left.right.top.bottom.equalTo(self.view)
        }

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    //TODO:还没写完
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifer)
        }
        cell?.textLabel?.text = String(format:"测试%ld", indexPath.row)
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section:\(indexPath.section)" + "\n row: \(indexPath.row)")
    }

}
