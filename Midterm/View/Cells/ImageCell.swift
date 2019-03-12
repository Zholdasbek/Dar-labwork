//
//  ImageCell.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell, ConfigurableCell {
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    func configure(data picture: Picture) {
        cellImageView.backgroundColor = picture.color
    }
    
    func setupLayout() {
        addSubview(cellImageView)
        cellImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(80)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
