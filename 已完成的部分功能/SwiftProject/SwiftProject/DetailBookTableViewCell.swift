//
//  DetailBookTableViewCell.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/20.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

class DetailBookTableViewCell: UITableViewCell {

    var messageLabel: UILabel! = {
        
        var label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()
    
    func setMessage(with message: String) {
        do {
            
            let msgAttributeString = try NSAttributedString(data: message.data(using: String.Encoding.unicode, allowLossyConversion: true)! ,options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            self.messageLabel.attributedText = msgAttributeString

        } catch {
            print("error:\(error)")
        }
    }
    
    private let padding = 10.0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.contentView.backgroundColor = UIColor.HJColorBack()
        self.contentView.addSubview(self.messageLabel)
        self.messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(padding)
            make.leading.equalTo(self.contentView).offset(padding)
            make.trailing.equalTo(self.contentView).offset(-padding)
        }
        
        //relayout the contentview of
        contentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.messageLabel.snp.bottom)
            make.top.leading.trailing.equalTo(self)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
