//
//  TSButtonRowItem.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 24/08/2024.
//

import UIKit

class TSRowButtonItem: UIView {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(image: UIImage, title: String) {
        super.init(frame: .zero)
        
        // Configure the image view
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        //imageView.tintColor = .systemGreen // You can change the tint color here
        
        // Configure the label
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12) // Adjust font size as needed
        //titleLabel.textColor = .systemGreen // You can change the text color here
        
        // Add subviews
        addSubview(imageView)
        addSubview(titleLabel)
        
        // Set up Auto Layout constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Center the image horizontally and place it at the top
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            
            // Center the label horizontally and place it below the image
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
