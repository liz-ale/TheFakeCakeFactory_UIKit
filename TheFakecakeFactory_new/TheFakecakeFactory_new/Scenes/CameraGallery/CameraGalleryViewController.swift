//
//  CameraGalleryViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 05/08/24.
//

import UIKit

class CameraGalleryViewController: UIViewController {
    
    private let cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customBgPurple
        button.layer.cornerRadius = 35
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return button
    }()
    
    private let cameraLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cámara"
        label.textAlignment = .center
        return label
    }()
    
    private let galleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "photo.on.rectangle"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customTabItemPink2
        button.layer.cornerRadius = 35
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return button
    }()
    
    private let galleryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Galería"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Foto de Perfil"
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        // Añadir subviews
        view.addSubview(cameraButton)
        view.addSubview(cameraLabel)
        view.addSubview(galleryButton)
        view.addSubview(galleryLabel)
        
        // Configurar Auto Layout
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for cameraButton
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -75),
            cameraButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Constraints for cameraLabel
            cameraLabel.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 10),
            cameraLabel.centerXAnchor.constraint(equalTo: cameraButton.centerXAnchor),
            
            // Constraints for galleryButton
            galleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 75),
            galleryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Constraints for galleryLabel
            galleryLabel.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 10),
            galleryLabel.centerXAnchor.constraint(equalTo: galleryButton.centerXAnchor)
        ])
    }
}

// Uso de SFSymbols para los iconos de los botones
// Nota: Asegúrate de usar SFSymbols o de añadir tus propios iconos de cámara e imagen a tu proyecto

