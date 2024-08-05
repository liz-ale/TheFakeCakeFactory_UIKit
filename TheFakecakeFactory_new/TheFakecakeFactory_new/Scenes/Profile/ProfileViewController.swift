//
//  ProfileViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.customGray.cgColor
       view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    // Sección 1
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 114).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 114).isActive = true
        imageView.layer.cornerRadius = 57
        imageView.layer.borderColor = UIColor.customGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = createLabel(text: "Nombre")
    private let emailLabel: UILabel = createLabel(text: "Email")
    private let phoneLabel: UILabel = createLabel(text: "Phone")
    private let addressLabel: UILabel = createLabel(text: "Address")
    
    // Línea divisoria
    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    // Sección 2
    private let editProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Editar perfil"
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true
        label.heightAnchor.constraint(equalToConstant: 21).isActive = true
        return label
    }()
    
    private let nameTextField: UITextField = createTextField(placeholder: "Nombre")
    private let emailTextField: UITextField = createTextField(placeholder: "Email")
    private let phoneTextField: UITextField = createTextField(placeholder: "Phone")
    private let addressTextField: UITextField = createTextField(placeholder: "Address")
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Actualizar", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.widthAnchor.constraint(equalToConstant: 141).isActive = true
        button.heightAnchor.constraint(equalToConstant: 47).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBgPink
        setupView()
    }
    
    private func setupView() {
        view.addSubview(containerView)
        
        // Añadir subviews al contenedor
        containerView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(phoneLabel)
        containerView.addSubview(addressLabel)
        containerView.addSubview(separatorLine)
        containerView.addSubview(editProfileLabel)
        containerView.addSubview(nameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(addressTextField)
        containerView.addSubview(updateButton)
        
        // Configurar Auto Layout
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for containerView
            
//            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 14),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 584),
            
            // Constraints for profileImageView
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            // Constraints for labels aligned with profileImageView
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            emailLabel.heightAnchor.constraint(equalToConstant: 40),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            phoneLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            phoneLabel.heightAnchor.constraint(equalToConstant: 40),
            
            addressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            addressLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Constraints for separatorLine
            separatorLine.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            separatorLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            separatorLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            separatorLine.heightAnchor.constraint(equalToConstant: 2),
            
            // Constraints for editProfileLabel
            editProfileLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 20),
            editProfileLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            // Constraints for text fields
            nameTextField.topAnchor.constraint(equalTo: editProfileLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            phoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addressTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10),
            addressTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            addressTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Constraints for updateButton
            updateButton.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            updateButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20)
        ])
    }
    
    private static func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.widthAnchor.constraint(equalToConstant: 352).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return label
    }
    
    private static func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.widthAnchor.constraint(equalToConstant: 352).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }
}
