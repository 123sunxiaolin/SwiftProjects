//
//  BookTableViewCell.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/18.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit
import Kingfisher

class BookTableViewCell: UITableViewCell {

    private lazy var avatarImageView: UIImageView! = {
        var imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    private lazy var nameLabel: UILabel! = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var authorLabel: UILabel! = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var summaryLabel: UILabel! = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var recommentCountLabel: UILabel! = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var collectionCountLabel: UILabel! = {
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var summaryTextView: UITextView! = {
        var textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 4.0
        textView.clipsToBounds = true
        return textView
    }()
    
    
    private let leftPadding = 20.0
    private let rightPadding = 20.0
    private let topPadding = 10.0
    private let avatarHeight = 100.0
    private let avatarWidth = 100.0 * 149/216
    private let labelHeight = 20.0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make)-> Void in
            make.left.equalTo(self.snp.left).offset(leftPadding)
            //make.centerY.equalTo(self.snp.centerY)
            make.top.equalTo(self.snp.top).offset(topPadding)
            make.size.equalTo(CGSize(width: avatarWidth, height: avatarHeight))
        }
        
        self.addSubview(self.recommentCountLabel)
        self.recommentCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(topPadding * 0.2)
            make.right.equalTo(self.avatarImageView.snp.centerX)
            make.size.equalTo(CGSize(width: avatarWidth/2, height: labelHeight))
        }
        
        self.addSubview(self.collectionCountLabel)
        self.collectionCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.centerX)
            make.top.equalTo(self.recommentCountLabel)
            make.size.equalTo(self.recommentCountLabel)
        }
        
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(leftPadding)
            make.top.equalTo(self.avatarImageView)
            make.right.equalTo(self.snp.right).offset(-rightPadding)
            make.height.equalTo(labelHeight)
        }
        
        self.addSubview(self.authorLabel)
        self.authorLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.nameLabel)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(topPadding * 0.1)
        }
        
        /*self.addSubview(self.summaryLabel)
        self.summaryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.authorLabel)
            make.top.equalTo(self.authorLabel.snp.bottom).offset(topPadding * 0.1)
            make.right.lessThanOrEqualTo(self.snp.right)
        }*/
        
        self.addSubview(self.summaryTextView)
        self.summaryTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.authorLabel)
            make.top.equalTo(self.authorLabel.snp.bottom).offset(topPadding * 0.1)
            make.right.equalTo(self.snp.right).offset(-rightPadding)
            make.bottom.equalTo(self.snp.bottom).offset(-topPadding)
        }
        
    }
    
    public func setBookModel(with book: Book) {
        
        let  imageUrl = URL(string: book.img)
        let placeHolderImage = UIImage(named: "kingfisher")
        self.avatarImageView.kf.setImage(with: imageUrl, placeholder: placeHolderImage)
        
        self.recommentCountLabel.text = "\(book.rcount!)"
        self.collectionCountLabel.text = "\(book.fcount!)"
        
        self.nameLabel.text = book.name
        self.authorLabel.text = book.author
        //self.summaryLabel.text = book.summary
        self.summaryTextView.text = book.summary
        
    }
    

}
