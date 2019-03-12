//
//  CompanyView.swift
//  Midterm
//
//  Created by Zholdas on 3/10/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {

    let companiesName: UILabel = {
        let tf = UILabel()
        tf.text = "Company"
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    lazy var companiesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Swift")
        imageView.layer.cornerRadius = 20
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 0.7
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(companiesName)
        view.addSubview(companiesImage)
        
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupPage()
        
        navigationItem.title = "Company Information"

    
    }
}
extension CompanyViewController {
    func setupPage() {
        [companiesName.topAnchor.constraint(equalTo: companiesImage.bottomAnchor, constant: 20),
         companiesName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         companiesName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
         companiesName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
         companiesName.heightAnchor.constraint(equalToConstant: 50),
         
         companiesImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
         companiesImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         companiesImage.widthAnchor.constraint(equalToConstant: 200),
         companiesImage.heightAnchor.constraint(equalToConstant: 100)
            ].forEach{ $0.isActive = true}
        
    }
}


