//
//  UserCell.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell, ConfigurableCell {
    
    let containerView = UIView()
    let cornerRadius: CGFloat = 25.0

    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "aa2")
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Placeholder text 🤑"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    func configure(data user: User) {
        usernameLabel.text = user.username
        userImageView.image = user.image
    }
    
    func setupLayout() {
        
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = 0.7
        containerView.layer.shadowColor = UIColor.black.cgColor
        

        
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = cornerRadius
        
        
        addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        containerView.addSubview(userImageView)
        
        userImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        userImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 7 ).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerView.addSubview(usernameLabel)
        
        usernameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 7 ).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


