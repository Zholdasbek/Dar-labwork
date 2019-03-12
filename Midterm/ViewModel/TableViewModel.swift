//
//  TableViewModel.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import Foundation
import UIKit
import CoreData


typealias UserCellConfigurator = TableCellConfigurator<UserCell, User>
typealias CompanyCellConfigurator = TableCellConfigurator<CompanyCell, Company>


class TableViewModel {
    
    var items: [[CellConfigurator]] = [[],[]]
    
//    var users: [String] = ["Baglan","Ahmi"]
    var founders: [DBFounder] = []
    var companies: [DBCompany] = []
    
        init() {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do {
                founders = try context.fetch(DBFounder.fetchRequest())
                companies = try context.fetch(DBCompany.fetchRequest())
            } catch {
                print(error)
            }
            
            
            for n in founders{
                
                let image = n.founderImage as NSData?

                items[0].append(UserCellConfigurator.init(item: User(username: n.founderName!, image: UIImage(data: image! as Data)!)))
                print(n)
            }
            for n in companies{
                let image = n.companyImage as NSData?
                
                items[1].append(CompanyCellConfigurator.init(item: Company(companyName: n.companyName! , companyDate: n.companyDate!, companyImage: UIImage(data: image! as Data)! )))
                }
    }
}
