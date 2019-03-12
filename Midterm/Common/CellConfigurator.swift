//
//  CellConfigurator.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    static var reuseId: String {
        return CellType.reuseIdentifier
    }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
}
