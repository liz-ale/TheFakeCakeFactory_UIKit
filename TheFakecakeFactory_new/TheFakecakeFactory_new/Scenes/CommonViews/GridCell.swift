//
//  GridCell.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class GridCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = (UIScreen.main.bounds.width - 40) / 6
        imageView.layer.borderColor = UIColor.systemPurple.cgColor
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
}

