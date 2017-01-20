//
//  DetailView.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/19.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

protocol DetailDelegate {
    func didselectBook(with book: DetailBook)
}

class DetailView: UIView {

    // MARK: lazy getters
    private lazy var topBackgroundView: UIView! = {
        var aView = UIView()
        aView.backgroundColor = UIColor.white
        return aView
    }()
    
    private lazy var bookImageView: UIImageView! = {
        var aImageView = UIImageView()
        aImageView.backgroundColor = UIColor.HJColorBack()
        return aImageView
    }()
    
    private lazy var nameLabel: UILabel! = {
        var aLabel = UILabel()
        aLabel.backgroundColor = UIColor.clear
        aLabel.textColor = UIColor.black
        aLabel.font = UIFont.systemFont(ofSize: 15)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var authorLabel: UILabel! = {
        var aLabel = UILabel()
        aLabel.backgroundColor = UIColor.clear
        aLabel.textColor = UIColor.colorWithHexString(hex: "#666666")
        aLabel.font = UIFont.systemFont(ofSize: 15)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var timeLabel: UILabel! = {
        var aLabel = UILabel()
        aLabel.backgroundColor = UIColor.clear
        aLabel.textColor = UIColor.colorWithHexString(hex: "#666666")
        aLabel.font = UIFont.systemFont(ofSize: 15)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var collectionLabel: UILabel! = {
        var aLabel = UILabel()
        aLabel.backgroundColor = UIColor.clear
        aLabel.textColor = UIColor.colorWithHexString(hex: "#999999")
        aLabel.font = UIFont.systemFont(ofSize: 15)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var recommentLabel: UILabel! = {
        var aLabel = UILabel()
        aLabel.backgroundColor = UIColor.clear
        aLabel.textColor = UIColor.colorWithHexString(hex: "#999999")
        aLabel.font = UIFont.systemFont(ofSize: 15)
        aLabel.textAlignment = .left
        return aLabel
    }()
    
    private lazy var summaryTitleLabel: UILabel! = {
        var aLabel = UILabel()
        aLabel.backgroundColor = UIColor.clear
        aLabel.textColor = UIColor.colorWithHexString(hex: "#000000")
        aLabel.font = UIFont.systemFont(ofSize: 16)
        aLabel.textAlignment = .left
        aLabel.text = "简介"
        return aLabel
    }()
    
    private lazy var summaryLabel: UILabel! = {
        var aLabel = UILabel()
        aLabel.backgroundColor = UIColor.clear
        aLabel.textColor = UIColor.colorWithHexString(hex: "#666666")
        aLabel.font = UIFont.systemFont(ofSize: 15)
        aLabel.textAlignment = .left
        aLabel.numberOfLines = 0
        aLabel.text = "- -"
        return aLabel
    }()
    
    private lazy var summaryTextView: UITextView! = {
        
        var textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.HJColorLine().cgColor
        textView.layer.cornerRadius = 4.0
        textView.clipsToBounds = true
        return textView
    }()
    
    private lazy var bookTableView: UITableView! = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        
        return tableView
    }()
    
    fileprivate var subSectionArray = [DetailBook]()
    
    private var leftPadding = 15.0
    private var rightPadding = 15.0
    private var topPadding = 10.0
    
    private var imageViewWidth = 80
    private var imageViewHeight = 120
    
    private var topHeight = 140.0
    private var labelHeight = 20.0
    private var summaryHeight = 120.0
    
    public var delegate: DetailDelegate?
    
    // MARK: public Closure
    public var callbackHandle: DidSelectHandler?
   
    
    var bookModel: DetailBookModel!
    {
        didSet{
            let url = URL(string: bookModel.img)
            self.bookImageView.kf.setImage(with: url)
            
            self.nameLabel.text = bookModel.name
            self.authorLabel.text = bookModel.author
            self.timeLabel.text = String.dateStringFromTimeStamp(timeStamp: bookModel.time!)
            self.collectionLabel.text = "收藏数: " + "\(bookModel.fcount!)"
            self.recommentLabel.text = "评论数: " + "\(bookModel.rcount!)"
            self.summaryTextView.text = bookModel.summary
        
            self.subSectionArray = bookModel.list!
            self.subSectionArray.reverse()
            self.bookTableView.reloadData()
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initTopView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTopView() {
        self.addSubview(self.topBackgroundView)
        self.topBackgroundView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(topHeight)
        }
        
        self.topBackgroundView.addSubview(self.bookImageView)
        self.bookImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(leftPadding)
            make.top.equalTo(self).offset(topPadding)
            make.size.equalTo(CGSize(width: imageViewWidth, height: imageViewHeight))
        }
        
        self.topBackgroundView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.bookImageView)
            make.left.equalTo(self.bookImageView.snp.right).offset(leftPadding)
            make.right.equalTo(self.topBackgroundView.snp.right).offset(-rightPadding)
        }
        self.nameLabel.text = "- -"
        
        self.topBackgroundView.addSubview(self.authorLabel)
        self.authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(topPadding)
            make.left.equalTo(self.nameLabel)
            make.right.equalTo(self.nameLabel)
        }
        self.authorLabel.text = "- -"
        
        self.topBackgroundView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.authorLabel.snp.bottom).offset(topPadding)
            make.left.equalTo(self.authorLabel)
            make.right.equalTo(self.authorLabel)
        }
        self.timeLabel.text = "- -"
        
        self.topBackgroundView.addSubview(self.collectionLabel)
        self.collectionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.timeLabel.snp.bottom).offset(topPadding)
            make.left.equalTo(self.authorLabel)
        }
        self.collectionLabel.text = "- -"
        
        self.topBackgroundView.addSubview(self.recommentLabel)
        self.recommentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionLabel)
            make.left.equalTo(self.collectionLabel.snp.right).offset(topPadding * 0.1)
            make.right.equalTo(self.timeLabel)
        }
        self.recommentLabel.text = "- -"
        
        //summary
        self.addSubview(self.summaryTitleLabel)
        self.summaryTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.topBackgroundView.snp.bottom).offset(topPadding)
            make.left.equalTo(self).offset(leftPadding)
            make.right.equalTo(self).offset(-rightPadding)
        }
        
        /*self.addSubview(self.summaryLabel)
        self.summaryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.summaryTitleLabel.snp.bottom).offset(topPadding)
            make.left.equalTo(self).offset(leftPadding)
            make.right.equalTo(self).offset(-rightPadding)
        }*/
        
        self.addSubview(self.summaryTextView)
        self.summaryTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.summaryTitleLabel.snp.bottom).offset(topPadding)
            make.left.equalTo(self).offset(leftPadding)
            make.right.equalTo(self).offset(-rightPadding)
            make.height.equalTo(summaryHeight)
        }
        
        self.addSubview(self.bookTableView)
        self.bookTableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self.summaryTextView.snp.bottom).offset(topPadding)
        }
        
    }

}


// MARK: - UITableViewDataSource
extension DetailView: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.subSectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let aBook = self.subSectionArray[section]
        return aBook.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifer = "DetailCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) as? DetailBookTableViewCell
        if cell == nil{
            cell = DetailBookTableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        let aBook = self.subSectionArray[indexPath.section]
        cell?.setMessage(with: aBook.message!)
        return cell!;
    }
}

// MARK: - UITableViewDelegate
extension DetailView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        /*guard self.delegate == nil else {
            return
        }*/
        
        let aBook = self.subSectionArray[indexPath.section]
        self.callbackHandle!(aBook)
        self.delegate?.didselectBook(with: aBook)
        
        
    }
}


