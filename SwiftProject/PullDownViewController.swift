//
//  PullDownViewController.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/11.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

class PullDownViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var tableView : UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private var refreshControl = UIRefreshControl()
    
    let originEmoji = ["😏😏😏", "😂😂😂", "😘😘😘", "👀👀👀", "👊🏻👊🏻👊🏻", "👍🏼👍🏼👍🏼", "🐔🐔🐔"]
    let newEmoji = ["🌚🌚🌚", "😱😱😱", "😳😳😳", "😄😄😄", "😂😂😂", "😘😘😘", "👀👀👀", "🙊🙊🙊", "🐶🐶🐶"]
    var emojiData = [String]()
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "下拉刷新"
        self.view.backgroundColor = UIColor.white
        
        emojiData = originEmoji
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make)->Void in
            make.left.right.top.bottom.equalTo(self.view)
        }
        
        self.tableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(didReloadData), for: .valueChanged)
        self.refreshControl.backgroundColor = UIColor.white
        let attributes = [NSForegroundColorAttributeName:UIColor.red]
        self.refreshControl.attributedTitle = NSAttributedString(string:"最近一次加载\(NSDate())", attributes:attributes)
        self.refreshControl.tintColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emojiData.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer = "newCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifer)
        if cell == nil {
            cell = UITableViewCell(style:.default, reuseIdentifier: identifer)
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = self.emojiData[indexPath.row]
     
        
        return cell!;
    }
    
    func didReloadData() {
        self.emojiData = newEmoji + originEmoji
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

}
