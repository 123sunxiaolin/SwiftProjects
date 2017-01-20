//
//  DetailViewController.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/19.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


typealias DidSelectHandler = (DetailBook) ->Void

class DetailViewController: UIViewController {

    public var id: Int?
    
    private lazy var detailView: DetailView = {
        var aView = DetailView()
        aView.delegate = self
        aView.backgroundColor = UIColor.HJColorBack()
        return aView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView! = {
        var activityView = UIActivityIndicatorView()
        activityView.activityIndicatorViewStyle = .gray
        activityView.hidesWhenStopped = true
        return activityView
    }()
    
    private let navOffset = 64.0
    
    
    /// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(customView: self.activityIndicator)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        // click TableView cell for callBack
        self.detailView.callbackHandle = { (response: DetailBook)-> Void in
            print("clickCell to callBack : \(response.title)")
        }
        
        self.view.addSubview(self.detailView)
        self.detailView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(navOffset)
            make.left.right.bottom.equalTo(self.view)
        }
        
        onRequestDetail()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startAnimating()  {
        self.activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        self.activityIndicator.stopAnimating()
    }
    
    /// network Request
    func onRequestDetail() {
        startAnimating()
        
        DispatchQueue.global().async {
            let request = RequestDetailBook()
            request.id = self.id
            print("request path:\(request.Path()) \n parameters:\(request.toJSON())")
            
            Alamofire.request(request.Path(), parameters: request.toJSON()).responseObject { (response: DataResponse<DetailBookModel>) in
                
                self.stopAnimating()
                guard let detailBookModel = response.result.value else{
                    print("error:\(response.result.error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.detailView.bookModel = detailBookModel
                }
            }
        }
        
    }

}

extension DetailViewController{
    
    //typealias DidSelectHandler = (DetailBook) ->()
}

// MARK: - DetailDelegate
extension DetailViewController: DetailDelegate{
    func didselectBook(with book: DetailBook) {
        print(book.title!)
    }
}
