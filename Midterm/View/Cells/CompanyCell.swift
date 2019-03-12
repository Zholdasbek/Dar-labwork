//
//  CompanyCell.swift
//  Midterm
//
//  Created by Zholdas on 3/4/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell, ConfigurableCell {
    
    
    let containerView = UIView()
    let cornerRadius: CGFloat = 25.0

    
    let companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Swift")
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Placeholder text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateFounded: UILabel = {
        let label = UILabel()
        label.text = "10-12-2014"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    func configure(data company: Company) {
        companyNameLabel.text = company.companyName
        dateFounded.text = company.companyDate
        companyImageView.image = company.companyImage
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
        containerView.addSubview(companyImageView)
        containerView.addSubview(companyNameLabel)
        containerView.addSubview(dateFounded)
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true

        
        companyImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        companyImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        companyNameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 5).isActive = true
        companyNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        companyNameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        companyNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        dateFounded.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 5).isActive = true
        dateFounded.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        dateFounded.widthAnchor.constraint(equalToConstant: 150).isActive = true
        dateFounded.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
