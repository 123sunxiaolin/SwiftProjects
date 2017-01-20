//
//  MainViewController.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/11.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

import Foundation

import Alamofire

import ObjectMapper

class MainViewController: UIViewController {

    private lazy var funcListTableView : UITableView! = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let dataArray = [
        "ObjectMapper auto",
        "Json or ObjectMapper Manual"
    ]
    
    var responseArray = [Model]()
    
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

        self.requestClassify()
        self.requestInPaserMannual()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func objectToJson() {
        let aModel = Model()
        aModel.id = 1
        aModel.name = "test"
        print(aModel.toJSON())
        
    }
    
    func requestClassify() {
        DispatchQueue.global().async {
            
            let urlString = "http://www.tngou.net/api/book/classify"
            Alamofire.request(urlString).responseObject { (response: DataResponse<Subject>) in
                
                guard let aSubject = response.result.value else{return}
                if !aSubject.status!{
                    return
                }
                self.responseArray = aSubject.tngou!
                DispatchQueue.main.async {
                    self.funcListTableView.reloadData()
                }
            }
        }
    }
    
    /// ObjectMapper parse in Auto
    func requestInPaserAuto() {
        let urlString = "http://www.tngou.net/api/book/classify"
        
        Alamofire.request(urlString).responseObject { (response: DataResponse<Subject>) in
            
            let aSubject = response.result.value
            print(aSubject?.status ?? false)
            if let tngouArray = aSubject?.tngou{
                for model in tngouArray{
                    print(model.id ?? 0)
                    print(model.name ?? "")
                    print(model.description ?? "")
                    print(model.toJSON())
                }
            }
        }
    }
    
    
    /// ObjectMapper parse in Manual and only parse in JSONSerialization
    func requestInPaserMannual() {
        
        let urlString = "http://www.tngou.net/api/book/classify"
        Alamofire.request(urlString).responseJSON { (response) in
        
            print("request:\(response.request)")
            print("response:\(response.response)")
            print("data:\(response.data)")
            print("result:\(response.result)")
            
            let finalValue = JSON(response.result.value ?? "")
            
            let dataArray = finalValue["tngou"]
            var tempUserArray = [Model]()
            for i in 0..<dataArray.count{
                let user = Model(JSONString: dataArray[i].rawString()!)
                tempUserArray.append(user!)
            }
            
            print("data:\(finalValue["tngou"][0]["name"])")
            print("swiftyJson:\(finalValue)")
            print("rawData:\(finalValue.rawValue)")
            
            print("0-0:\(finalValue[0]["tngou"].arrayValue)")
            
            if let json = response.result.value{
                
                
                print("json:\(json)")
                let dict = json as! Dictionary<String, Any>
                let status = dict["status"] as? Int
                
                print("status:\(status)")
                
                let data = dict["tngou"] as? Array<Dictionary<String, Any>>
                
                var resultArray = [Model]()
                for aElement in data! {
                    let jsonSS = try? JSONSerialization.data(withJSONObject: aElement, options: .prettyPrinted)
                    let finalStr = NSString(data:jsonSS!, encoding: String.Encoding.utf8.rawValue) as! String
                    let user = Model(JSONString: finalStr)
                    resultArray.append(user!)
                }
                print(resultArray)
                
            }
            
        }
    }
    
    
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.responseArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifer)
        }
        cell?.textLabel?.text = String(format:"测试%ld", indexPath.row)
        let model = self.responseArray[indexPath.row]
        cell?.textLabel?.text = model.name
        cell?.detailTextLabel?.text = model.description
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
}


// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section:\(indexPath.section)" + "\n row: \(indexPath.row)")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*switch indexPath.row {
        case 0:
            self.requestInPaserAuto()
        case 1:
            self.requestInPaserMannual()
        default:
            return
        }*/
        
        let model = self.responseArray[indexPath.row]
        let bookVC = BookViewController()
        bookVC.title = model.name
        bookVC.id = model.id
        self.navigationController?.pushViewController(bookVC, animated: true)
        
    }
}
