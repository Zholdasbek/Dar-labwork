//
//  FounderViewController.swift
//  Midterm
//
//  Created by Zholdas on 3/10/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit

class FounderViewController: UIViewController {

    let foundersName: UILabel = {
        let tf = UILabel()
        tf.text = "Founder"
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()


    lazy var foundersImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "aa2")
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

        view.addSubview(foundersName)
        view.addSubview(foundersImage)

        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupPage()

        navigationItem.title = "Founder Information"


    }
}
extension FounderViewController {
    func setupPage() {
        [foundersName.topAnchor.constraint(equalTo: foundersImage.bottomAnchor, constant: 20),
         foundersName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         foundersName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
         foundersName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
         foundersName.heightAnchor.constraint(equalToConstant: 50),

         foundersImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
         foundersImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         foundersImage.widthAnchor.constraint(equalToConstant: 200),
         foundersImage.heightAnchor.constraint(equalToConstant: 200)
            ].forEach{ $0.isActive = true}

    }
}


