//
//  CustomTableViewCell.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//
import UIKit

class CustomTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let dessertImageView = UIImageView()
    let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        dessertImageView.layer.cornerRadius = 41
        dessertImageView.layer.borderWidth = 2
        dessertImageView.layer.borderColor = UIColor.purple.cgColor
        dessertImageView.clipsToBounds = true
        dessertImageView.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        contentView.addSubview(dessertImageView)
        contentView.addSubview(descriptionLabel)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            dessertImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dessertImageView.widthAnchor.constraint(equalToConstant: 82),
            dessertImageView.heightAnchor.constraint(equalToConstant: 82),

            nameLabel.leadingAnchor.constraint(equalTo: dessertImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            descriptionLabel.leadingAnchor.constraint(equalTo: dessertImageView.trailingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(name: String, description: String) {
        nameLabel.text = name
        dessertImageView.image = UIImage(named: "f1") // Usa una imagen placeholder o la imagen real
        descriptionLabel.text = description
    }
}
