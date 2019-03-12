//
//  AddingPage.swift
//  Midterm
//
//  Created by Zholdas on 3/1/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit
import CoreData

protocol MyProtocol {
    func setText(name: String, img: UIImage)
}


class AddingFounder: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let imagePicker = UIImagePickerController()
    
    let viewModel = TableViewModel()

    var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var myProtocol: MyProtocol?
    
    let founderName: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Name"
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 15
        tf.setLeftPaddingPoints(10)
        tf.setRightPaddingPoints(10)
        tf.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        tf.layer.shadowOpacity = 0.3
        tf.layer.shadowRadius = 0.7
        tf.layer.shadowColor = UIColor.black.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var founderImage: UIImageView = {
        let imageView = UIImageView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        imageView.addGestureRecognizer(tapGestureRecognizer)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "aa2")
        imageView.layer.cornerRadius = 50
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 0.7
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let tab = TablePage()
    let mod = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        view.addSubview(myTableView)
        view.addSubview(founderName)
        view.addSubview(founderImage)
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupPage()
        
        navigationItem.title = "Add Founded"
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addButton
        
        myTableView.separatorStyle = .none
        myTableView.estimatedRowHeight = 60
        myTableView.tableFooterView = UIView()
        myTableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        myTableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseIdentifier)
        myTableView.delegate = self
        myTableView.dataSource = self
    }

}

extension AddingFounder {
    func setupPage() {
        
       [myTableView.topAnchor.constraint(equalTo: founderImage.bottomAnchor, constant: 20),
        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        founderName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        founderName.leftAnchor.constraint(equalTo: founderImage.rightAnchor,constant: 10),
        founderName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -10),
        founderName.heightAnchor.constraint(equalToConstant: 50),
        
        founderImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        founderImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
        founderImage.widthAnchor.constraint(equalToConstant: 100),
        founderImage.heightAnchor.constraint(equalToConstant: 100)
            ].forEach{ $0.isActive = true}
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Companies"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[1].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[1][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    @objc func addTapped(){
        myProtocol?.setText(name: founderName.text!, img: founderImage.image!)
        navigationController?.popViewController(animated: true)
        
        let newFounder = NSEntityDescription.insertNewObject(forEntityName: "DBFounder", into: context)
        newFounder.setValue(self.founderName.text, forKey: "founderName")
        
        let imgData = founderImage.image?.jpegData(compressionQuality: 1)
        
        
        newFounder.setValue(imgData , forKey: "founderImage")
        
        print(newFounder)
        
        
        do {
            try context.save()
            print(newFounder)
            dismiss(animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    @objc func selectPhoto() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as?
            UIImage {
            founderImage.image = pickedImage
            dismiss(animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
