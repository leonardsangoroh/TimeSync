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
        configureIsWorkingStatus()
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
        localTimeLabel.text = contact.localTime + "hrs"
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
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
    
    
    func configureLocalTimeLabel() {
        localTimeLabel.numberOfLines = 1
        localTimeLabel.adjustsFontSizeToFitWidth = true
        localTimeLabel.textColor = .secondaryLabel
        localTimeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    
    func configureCountryLabel(){
        countryLabel.numberOfLines = 1
        countryLabel.adjustsFontSizeToFitWidth = true
        countryLabel.textColor = .secondaryLabel
        countryLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    func configureIsWorkingStatus() {
        isWorkingStatus.layer.cornerRadius = 5
    }
    
    func setViewConstraints() {
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        localTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        isWorkingStatus.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            profilePhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            profilePhoto.heightAnchor.constraint(equalToConstant: 60),
            profilePhoto.widthAnchor.constraint(equalToConstant: 60),
            
            isWorkingStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            isWorkingStatus.widthAnchor.constraint(equalTo:profilePhoto.widthAnchor),
            isWorkingStatus.heightAnchor.constraint(equalToConstant: 10),
            isWorkingStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 10),
            
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            countryLabel.heightAnchor.constraint(equalToConstant: 20),
            countryLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 10),
            
            localTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            localTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            localTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}
