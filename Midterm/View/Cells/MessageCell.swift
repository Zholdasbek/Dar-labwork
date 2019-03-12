//
//  MessageCell.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, ConfigurableCell {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Message placeholder text 🙌🏻"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    func configure(data message: String) {
        messageLabel.text = message
    }
    
    func setupLayout() {
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(32)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
