//
//  ContactTableViewCell.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 25/08/2024.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    var profilePhoto = UIImageView()
    var nameLabel = UILabel()
    var localTimeLabel = UILabel()
    var countryLabel = UILabel()
    var isWorkingStatus = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profilePhoto)
        addSubview(nameLabel)
        addSubview(localTimeLabel)
        addSubview(countryLabel)
        addSubview(isWorkingStatus)
        
        configureImageView()
        configureNameLabel()
        configureCountryLabel()
        configureLocalTimeLabel()
        setViewConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(contact: Contact) {
        profilePhoto.image = contact.profilePhoto
        nameLabel.text = contact.name
        localTimeLabel.text = contact.localTime
        countryLabel.text = contact.country
        
        // set isWorkingStatus
        if Int(contact.localTime)! > 800 && Int(contact.localTime)! < 1800 {
            isWorkingStatus.backgroundColor = .systemGreen
        } else {
            isWorkingStatus.backgroundColor = .systemRed
        }
    }
    
    
    func configureImageView(){
        profilePhoto.layer.cornerRadius = 30
        profilePhoto.clipsToBounds = true
    }
    
    
    func configureNameLabel() {
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    func configureLocalTimeLabel() {
        localTimeLabel.numberOfLines = 1
        localTimeLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    func configureCountryLabel(){
        countryLabel.numberOfLines = 1
        countryLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    func setViewConstraints() {
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        localTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        isWorkingStatus.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            profilePhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            profilePhoto.heightAnchor.constraint(equalToConstant: 60),
            profilePhoto.widthAnchor.constraint(equalToConstant: 60),
            
            isWorkingStatus.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 5),
            isWorkingStatus.widthAnchor.constraint(equalTo:profilePhoto.widthAnchor),
            isWorkingStatus.heightAnchor.constraint(equalToConstant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 10),
            
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            countryLabel.heightAnchor.constraint(equalToConstant: 20),
            countryLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 10),
            
            localTimeLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10),
            localTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            localTimeLabel.leadingAnchor.constraint(equalTo: isWorkingStatus.trailingAnchor, constant: 10)
        ])
    }
    
}
