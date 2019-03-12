//
//  AddingPage2.swift
//  Midterm
//
//  Created by Zholdas on 3/7/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

protocol MyProtocol2 {
    func setText2(name: String)
}


class AddingPage2: UIViewController {
    
    
    var myProtocol: MyProtocol2?
    
    let firstName: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Name"
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 15
        
        tf.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        tf.layer.shadowOpacity = 0.3
        tf.layer.shadowRadius = 0.7
        tf.layer.shadowColor = UIColor.black.cgColor
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .yellow
        imageView.layer.cornerRadius = 15
        
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 0.7
        imageView.layer.shadowColor = UIColor.black.cgColor
        
        
        //        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    let tab = TablePage()
    let mod = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(firstName)
        view.addSubview(profileImageView)
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupPage()
        
        navigationItem.title = "Add Company"
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc func addTapped(){
        myProtocol?.setText2(name: firstName.text!)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension AddingPage2 {
    func setupPage() {
        
        [firstName.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: 30),
         firstName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 50),
         firstName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -50),
         firstName.heightAnchor.constraint(equalToConstant: 50)
            ].forEach{ $0.isActive = true}
        
        [profileImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -150),
         profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         profileImageView.widthAnchor.constraint(equalToConstant: 275),
         profileImageView.heightAnchor.constraint(equalToConstant: 275)
            ].forEach{ $0.isActive = true}
        
    }
    
}
