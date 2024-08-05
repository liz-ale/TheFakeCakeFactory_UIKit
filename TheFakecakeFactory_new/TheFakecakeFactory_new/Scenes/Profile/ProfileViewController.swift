//
//  ProfileViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.alignment = .center
        mainStack.spacing = 20
        mainStack.backgroundColor = UIColor.white
        mainStack.layer.borderWidth = 1
        mainStack.layer.borderColor = UIColor.gray.cgColor
        mainStack.layer.cornerRadius = 51
        mainStack.layer.opacity = 1
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        view.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 14),
            //            mainStack.widthAnchor.constraint(equalToConstant: 200),
            //            mainStack.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        // Sección 1: HStack con imagen de perfil y detalles del usuario
        let profileSection = UIStackView()
        profileSection.axis = .horizontal
        profileSection.alignment = .leading
        profileSection.spacing = 10
        mainStack.addArrangedSubview(profileSection)
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .gray
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileSection.addArrangedSubview(profileImageView)
        
        let detailsStack = UIStackView()
        detailsStack.axis = .vertical
        detailsStack.alignment = .leading
        detailsStack.spacing = 5
        profileSection.addArrangedSubview(detailsStack)
        
        let usernameLabel = UILabel()
        usernameLabel.text = "ipsum123"
        detailsStack.addArrangedSubview(usernameLabel)
        
        let nameLabel = UILabel()
        nameLabel.text = "Lorem Ipsum"
        detailsStack.addArrangedSubview(nameLabel)
        
        let emailLabel = UILabel()
        emailLabel.text = "lorem.ipsum@example.com"
        detailsStack.addArrangedSubview(emailLabel)
        
        let phoneLabel = UILabel()
        phoneLabel.text = "+52 123 456 7890"
        detailsStack.addArrangedSubview(phoneLabel)
        
        let addressLabel = UILabel()
        addressLabel.text = "Calle Falsa 123"
        detailsStack.addArrangedSubview(addressLabel)
        
        // Sección 2: VStack con "Editar Usuario" y textfields para editar información
        let editSection = UIStackView()
        editSection.axis = .vertical
        editSection.alignment = .center
        editSection.spacing = 10
        mainStack.addArrangedSubview(editSection)
        
        let editLabel = UILabel()
        editLabel.text = "Editar Usuario"
        editLabel.font = UIFont.boldSystemFont(ofSize: 18)
        editSection.addArrangedSubview(editLabel)
        
        let usernameTextField = createTextField(placeholder: "Nombre de usuario")
        editSection.addArrangedSubview(usernameTextField)
        
        let nameTextField = createTextField(placeholder: "Nombre")
        editSection.addArrangedSubview(nameTextField)
        
        let emailTextField = createTextField(placeholder: "Email")
        editSection.addArrangedSubview(emailTextField)
        
        let phoneTextField = createTextField(placeholder: "Teléfono")
        editSection.addArrangedSubview(phoneTextField)
        
        let addressTextField = createTextField(placeholder: "Dirección")
        editSection.addArrangedSubview(addressTextField)
        
        lazy var updateInfoButton: UIButton = {
            var configuration = UIButton.Configuration.bordered()
            configuration.title = "Actualizar"
            configuration.background.cornerRadius = CGFloat (20.0)
            let button = UIButton(configuration: configuration)
            button.layer.borderColor = UIColor.gray.cgColor
            button.tintColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
            return button
        }()
        editSection.addArrangedSubview(updateInfoButton)
        
    }
    
    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return textField
    }
    
    @objc private func updateButtonTapped() {
        print("Actualizar información del usuario")
    }
}
