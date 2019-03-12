//
//  AddingCompany.swift
//  Midterm
//
//  Created by Zholdas on 3/8/19.
//  Copyright © 2019 Zholdas. All rights reserved.
//

import UIKit
import CoreData

protocol MyProtocol2 {
    func setText2(name: String, date: String, img: UIImage)
}

class AddingCompany: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let imagePicker = UIImagePickerController()

    
    var myProtocol2: MyProtocol2?
    
    let companyName: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Company Name"
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
    
    let dateTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Founded Date"
        tf.setLeftPaddingPoints(10)
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 15
        
        tf.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        tf.layer.shadowOpacity = 0.3
        tf.layer.shadowRadius = 0.7
        tf.layer.shadowColor = UIColor.black.cgColor
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    lazy var companyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Swift")
        imageView.layer.cornerRadius = 20
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 0.7
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        return picker
    }()
    
    lazy var toolbar: UIToolbar = {
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = .white
        
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(todayPressed(_:)))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed(_:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
       
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
        label.text = "Select a date"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        
        let labelButton = UIBarButtonItem(customView: label)
        toolbar.setItems([todayButton, flexButton, labelButton, flexButton, doneButton], animated: true)
        return toolbar
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        view.addSubview(companyName)
        view.addSubview(companyImage)
        view.addSubview(dateTextField)
        
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupPage()
        
        navigationItem.title = "Add Company"
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addButton
        
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
    }
}

extension AddingCompany {
    func setupPage() {
        [companyName.topAnchor.constraint(equalTo: companyImage.bottomAnchor, constant: 20),
         companyName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         companyName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
         companyName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
         companyName.heightAnchor.constraint(equalToConstant: 50),
         
         dateTextField.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 20),
         dateTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         dateTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
         dateTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
         dateTextField.heightAnchor.constraint(equalToConstant: 50),
        
         companyImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
         companyImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         companyImage.widthAnchor.constraint(equalToConstant: 200),
         companyImage.heightAnchor.constraint(equalToConstant: 100)
            ].forEach{ $0.isActive = true}
        
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func todayPressed(_ sender: UIBarButtonItem) {
        dateTextField.text = dateFormatter.string(from: Date())
        dateTextField.resignFirstResponder()
    }
    
    @objc func donePressed(_ sender: UIBarButtonItem) {
        dateTextField.resignFirstResponder()
    }
    
    
    @objc func addTapped(){
        myProtocol2?.setText2(name: companyName.text!, date: dateTextField.text!, img: companyImage.image!)
        navigationController?.popViewController(animated: true)

        // MARK: CoreData
        let newCompany = NSEntityDescription.insertNewObject(forEntityName: "DBCompany", into: context)
        newCompany.setValue(self.companyName.text, forKey: "companyName")
        newCompany.setValue(self.dateTextField.text, forKey: "companyDate")
        
        let imgData = companyImage.image?.jpegData(compressionQuality: 1)
        newCompany.setValue(imgData , forKey: "companyImage")

        do {
            try context.save()
            print(newCompany)
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
            companyImage.image = pickedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


