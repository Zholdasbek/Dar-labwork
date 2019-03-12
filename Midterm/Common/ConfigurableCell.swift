//
//  ConfigurableCell.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    func setupLayout()
    func configure(data: DataType)
    static var reuseIdentifier: String { get } // в будущем как KEY, для cell actions
}

extension ConfigurableCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
