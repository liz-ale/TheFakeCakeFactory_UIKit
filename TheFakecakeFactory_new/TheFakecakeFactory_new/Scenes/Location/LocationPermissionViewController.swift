//
//  LocationPermissionsViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class LocationPermissionsViewController: UIViewController {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Esta aplicación necesita acceder a tu ubicación para ofrecerte una mejor experiencia. Por favor, concede acceso a la ubicación en los ajustes de la aplicación."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .customGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.layer.cornerRadius = 20
       // button.layer.borderColor = UIColor.systemPurple.cgColor
        button.layer.borderColor = UIColor.customGray.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let permissionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dar Permiso", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.customGray.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textLabel)
        view.addSubview(cancelButton)
        view.addSubview(permissionButton)
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        permissionButton.addTarget(self, action: #selector(permissionButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalToConstant: 150),
            
            
            permissionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            permissionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            permissionButton.heightAnchor.constraint(equalToConstant: 40),
            permissionButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func permissionButtonTapped() {
        let mapVC = MapViewController()
        mapVC.modalPresentationStyle = .fullScreen
        present(mapVC, animated: true, completion: nil)
    }
}
