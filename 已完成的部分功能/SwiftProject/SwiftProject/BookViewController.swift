//
//  BookViewController.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/17.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class BookViewController: UIViewController {

    public var id: Int?
    
    let headers: HTTPHeaders = [
        "Accept": "text/plain"
    ]
    
    // MARK: getters
    private lazy var bookTableView: UITableView! = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView! = {
        var activityView = UIActivityIndicatorView()
        activityView.activityIndicatorViewStyle = .gray
        activityView.hidesWhenStopped = true
        return activityView
    }()
    
    private lazy var tableHeader: MJRefreshNormalHeader! = {
        var aHeader = MJRefreshNormalHeader()
        aHeader.setRefreshingTarget(self, refreshingAction: #selector(onRequestBook))
        return aHeader
    }()
    
    private lazy var tableGifHeader: MJRefreshGifHeader! = {
        var header = MJRefreshGifHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(onRequestBook))
        return header
    }()
    
    private lazy var tableGifFooter: MJRefreshAutoGifFooter! = {
        var footer = MJRefreshAutoGifFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(onPushToReload))
        return footer
    }()
    
    private let currentRows = 20
    private var currentPage = 1
    private let url = "http://www.tngou.net/api/book/list"
    
    private var bookList: BookList!
    var idleImages = [UIImage]()
    var refreshImages = [UIImage]()
    fileprivate var dataArray = [Book]()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...60{
            let image = UIImage(named: "dropdown_anim__000\(i)")
            idleImages.append(image!)
        }
        
        for i in 1...3{
            let image = UIImage(named: "dropdown_loading_0\(i)")
            refreshImages.append(image!)
        }
        
        self.view.backgroundColor = UIColor.white
        self.tableGifHeader.setImages(idleImages, for: .idle)
        self.tableGifHeader.setImages(idleImages, for: .refreshing)
        self.tableGifHeader.setImages(refreshImages, for: .pulling)
        self.bookTableView.mj_header = self.tableGifHeader
        
        self.tableGifFooter.setImages(idleImages, for: .idle)
        self.tableGifFooter.setImages(idleImages, for: .refreshing)
        self.tableGifFooter.setImages(refreshImages, for: .pulling)
         self.bookTableView.mj_footer = self.tableGifFooter
        
        self.view.addSubview(self.bookTableView)
        
        let rightBarButton = UIBarButtonItem(customView: self.activityIndicator)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.onRequestBook()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.bookTableView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initRefreshHeaders() {
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(onRequestBook))
        self.bookTableView.mj_header = header
    }
    
    func startAnimating()  {
        self.activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        self.activityIndicator.stopAnimating()
    }
    
    func onPushToReload() {
        guard self.currentPage < self.bookList.totalpage! else {
            self.tableGifFooter.endRefreshing()
            return
        }
        
        self.currentPage += 1
        onRequestBook()
    }
    
    func onRequestBook() {

        startAnimating()
        DispatchQueue.global().async {
            let book = RequestBook()
            book.id = self.id
            book.rows = self.currentRows
            book.page = self.currentPage
            print("request parameters:\(book.toJSON())")
            print("request url:\(book.path())")
            
            Alamofire.request(book.path(), parameters: book.toJSON() ).responseObject { (response: DataResponse<BookList>) in
                
                self.stopAnimating()
                self.tableGifHeader.endRefreshing()
                self.tableGifFooter.endRefreshing()
                
                guard let bookList = response.result.value else{
                    print("\(response.result.error)")
                    return
                }
                self.bookList = bookList
                //self.dataArray = bookList.list!
                for e in bookList.list!{
                    self.dataArray.append(e)
                }
                DispatchQueue.main.async {
                    self.bookTableView.reloadData()
                }
            }

        }
    }

}

// MARK: - UITableViewDataSource
extension BookViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer = "BookCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifer) as? BookTableViewCell
        if cell == nil {
            cell = BookTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifer)
        }
        let book = self.dataArray[indexPath.row]
        cell?.setBookModel(with: book)
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension BookViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let bookModel = self.dataArray[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.title = bookModel.name
        detailVC.id = bookModel.id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

