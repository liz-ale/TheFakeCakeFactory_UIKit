//
//  MapViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class MapViewController: UIViewController {
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cerrar", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let navigateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cómo llegar", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Configurar mapa aquí
        
        view.addSubview(closeButton)
        view.addSubview(navigateButton)
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        navigateButton.addTarget(self, action: #selector(navigateButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            navigateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            navigateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func navigateButtonTapped() {
        // Acción para "Cómo llegar"
    }
}
