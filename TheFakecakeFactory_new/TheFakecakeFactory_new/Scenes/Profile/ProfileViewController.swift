//
//  ProfileViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let storageProvider: StorageProvider
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.gray.cgColor
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
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true // Habilitar la interacción del usuario
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Línea divisoria
    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customGrayLight
        return view
    }()
    
    // Sección 2
    private let editProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Editar perfil"
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
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
        button.tintColor = .customGray
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.widthAnchor.constraint(equalToConstant: 130).isActive = true
        button.heightAnchor.constraint(equalToConstant: 47).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBgPink
        setupView()
        
        // Añadir tap gesture recognizer a la imagen de perfil
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        loadUserData()
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
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            containerView.heightAnchor.constraint(equalToConstant: 584),
            
            // Constraints for profileImageView
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            // Constraints for labels aligned with profileImageView
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            
            addressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            
            // Constraints for separatorLine
            separatorLine.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            separatorLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            // Constraints for editProfileLabel
            editProfileLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 20),
            editProfileLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            // Constraints for textFields
            nameTextField.topAnchor.constraint(equalTo: editProfileLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            phoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            addressTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10),
            addressTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Constraints for updateButton
            updateButton.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            updateButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private static func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    private static func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        return textField
    }
    
    @objc private func profileImageTapped() {
        let locationVC = CameraGalleryViewController()
        locationVC.modalPresentationStyle = .pageSheet
        
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return 150
        }
        
        if let sheet = locationVC.sheetPresentationController {
            //sheet.detents = [.medium()]
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = true
        }
        present(locationVC, animated: true, completion: nil)
    }
    
    private func loadUserData() {

        guard let user = self.storageProvider.currentUser else { return }
        nameLabel.text = "\(user.name ?? "Nombre")"
        emailLabel.text = "\(user.email ?? "Email")"
        phoneLabel.text = "\(user.phone ?? "Telefóno")"
        addressLabel.text = "\(user.address ?? "Dirección")"
    }
}
