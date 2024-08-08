//
//  CameraGalleryViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 05/08/24.
//

import UIKit

class CameraGalleryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let storageProvider: StorageProvider
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    var profileImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Foto de Perfil"
        setupView()
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
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
    
    @objc private func galleryButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    @objc private func cameraButtonTapped() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            // Mostrar una alerta si la cámara no está disponible
            let alert = UIAlertController(title: "Error", message: "La cámara no está disponible en este dispositivo.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImageView?.image = selectedImage
        let _ = selectedImage.jpegData(compressionQuality: 0.8)
        storageProvider.updateUserProfileImage(selectedImage)
        picker.dismiss(animated: true, completion: nil)
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
