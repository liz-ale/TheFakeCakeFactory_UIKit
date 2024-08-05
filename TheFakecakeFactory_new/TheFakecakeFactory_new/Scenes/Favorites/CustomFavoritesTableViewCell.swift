//
//  CustomFavoritesTableView.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 05/08/24.
//

import UIKit
class CustomFavoritesTableViewCell: UITableViewCell {

    let cellImageView = UIImageView()
    let nameLabel = UILabel()
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
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.layer.cornerRadius = 41
        cellImageView.layer.borderColor = UIColor.purple.cgColor
        cellImageView.layer.borderWidth = 2
        cellImageView.clipsToBounds = true
        contentView.addSubview(cellImageView)

        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = .white
        contentView.addSubview(nameLabel)

        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
    }

    func setupLayout() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 80),
            cellImageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            descriptionLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(name: String, description: String, imageName: String) {
        nameLabel.text = name
        descriptionLabel.text = description
        cellImageView.image = UIImage(named: imageName)
    }
}

