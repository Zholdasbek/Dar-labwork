//
//  WarningCell.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

class WarningCell: UITableViewCell, ConfigurableCell {
    
    let warningIcon: UILabel = {
        let label = UILabel()
        label.text = "⚠️"
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "x"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data message: String) {
        messageLabel.text = message
    }
    
    func setupLayout() {
        addSubview(warningIcon)
        warningIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(warningIcon.snp.trailing).offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
}
