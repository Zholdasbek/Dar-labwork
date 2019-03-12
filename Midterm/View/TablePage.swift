//
//  ViewController.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

class TablePage: UITableViewController, MyProtocol, MyProtocol2 {
  
    
    
    let viewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.reloadData()
        
        navigationItem.title = "Table Page"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createTapped))
        self.navigationItem.rightBarButtonItem = addButton
        
        
        tableViewSetup()
    }
    
    func setText(name: String , img: UIImage){
        
        viewModel.items[0].append(UserCellConfigurator.init(item: User(username: name, image: img)))
//        tableView.insertRows(at: [IndexPath(row: viewModel.users.count-1, section: 0)], with: .automatic)
        tableView.reloadData()
    }
    
    func setText2(name: String, date: String, img: UIImage){
        viewModel.items[1].append(CompanyCellConfigurator.init(item: Company(companyName: name, companyDate: date, companyImage: img)))
//        viewModel.companies.append([name,date])
        tableView.reloadData()
    }

 
    @objc func createTapped(){
        let addFounderView = AddingFounder()
        let addCompanyView = AddingCompany()

        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let addFounder = UIAlertAction(title: "Add Founder", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.navigationController?.pushViewController(addFounderView,animated: true)
        })
        addFounderView.myProtocol = self
        addCompanyView.myProtocol2 = self

        let addCompany = UIAlertAction(title: "Add Company", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.navigationController?.pushViewController(addCompanyView,animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        optionMenu.addAction(addFounder)
        optionMenu.addAction(addCompany)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)

    }
    
    
    private func tableViewSetup() {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseIdentifier)
    }
}

extension TablePage {
    
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
                return 80
        }
        else {
            return 130
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Founders"
        }
        else {
            return "Companies"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        if editingStyle == .delete {
            
            if indexPath.section == 0{

                let founderDelete = viewModel.founders[indexPath.row]
                context.delete(founderDelete)
                viewModel.items[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .automatic)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
                do {
                    viewModel.founders = try context.fetch(DBFounder.fetchRequest())
                } catch {
                    print(error)
                }
            }
            else if indexPath.section == 1{
                let companyDelete = viewModel.companies[indexPath.row]
                context.delete(companyDelete)
                viewModel.items[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .automatic)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                do {
                    viewModel.companies = try context.fetch(DBCompany.fetchRequest())
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count

    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[section].count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        // MARK: Error: doesn`t work when we add new data

        let companyView = CompanyViewController()
        let founderView = FounderViewController()
        if indexPath.section == 0{

            let Fname = viewModel.founders[indexPath.row].founderName
            let Fimage = viewModel.founders[indexPath.row].founderImage
            
            founderView.foundersName.text = Fname!
            founderView.foundersImage.image = UIImage(data: Fimage!)
            self.navigationController?.pushViewController(founderView,animated: true)
        }

        else if indexPath.section == 1 {
            let Cname = viewModel.companies[indexPath.row].companyName
            let Cimage = viewModel.companies[indexPath.row].companyImage
            
            companyView.companiesName.text = Cname!
            companyView.companiesImage.image = UIImage(data: Cimage!)
            self.navigationController?.pushViewController(companyView,animated: true)
        }
    }

}
