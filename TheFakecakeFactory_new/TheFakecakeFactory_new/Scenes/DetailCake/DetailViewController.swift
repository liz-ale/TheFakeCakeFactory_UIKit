//
//  DetailCakeViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class DetailViewController: UIViewController {

    private let cake: Cake
    let interactor: CakesInteractor
    
    init(cake: Cake, interactor: CakesInteractor) {
        self.cake = cake
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let imageURL = URL(string: "https://eniadesign.com.mx/\(cake.image)") {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }
        }
        
        view.addSubview(imageView)
        
        setupContainerView()
    }
    
    private func setupContainerView() {
        let containerView = UIView()
        containerView.backgroundColor = .customBgPurple
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.customBgPurple.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 377),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
        
        let nameLabel = UILabel()
        nameLabel.text = "\(cake.name)"
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        containerView.addSubview(nameLabel)
        
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share_icon"), for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.tintColor = .white
        
        containerView.addSubview(shareButton)
        
        let favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.tintColor = .white
        
        containerView.addSubview(favoriteButton)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "\(cake.description)"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .white
        
        containerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalToConstant: 250),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            shareButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            shareButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -60),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            
            favoriteButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Calcular el nuevo tamaño
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // Redimensionar la imagen
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
