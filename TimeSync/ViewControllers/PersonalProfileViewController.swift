//
//  PersonalProfileViewController.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 23/08/2024.
//

import UIKit

class PersonalProfileViewController: UIViewController {
    
    let profilePicture = UIImageView()
    let userNameLabel = UILabel()
    let userName = UILabel()
    let phoneNumberLabel = UILabel()
    let phoneNumber = UILabel()
    let emailLabel = UILabel()
    let email = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //view.backgroundColor = .systemBackground
        configureView()
        configureProfilePicture()
        configureUserNameLabel()
        configureUserName()
        configurePhoneNumberLabel()
        configurePhoneNumber()
        configureEmailLabel()
        configureEmail()
    }
    
    
    func configureView(){
        self.view.backgroundColor = UIColor(named: "background_color")
    }
    
    
    func configureProfilePicture() {
        
        view.addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.image = UIImage(named: "Lee")
        profilePicture.layer.cornerRadius = 100
        profilePicture.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            profilePicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.heightAnchor.constraint(equalToConstant: 200),
            profilePicture.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureUserNameLabel() {
        view.addSubview(userNameLabel)
        userNameLabel.text = "USERNAME"
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textColor = .secondaryLabel
        userNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            userNameLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 30)
        ])
    }
    
    
    func configureUserName() {
        view.addSubview(userName)
        userName.text = "   " + "LEE LEONARD SANGOROH"
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.textColor = .label
        userName.textAlignment = .natural
        userName.font = UIFont.preferredFont(forTextStyle: .body)
        userName.font = UIFont.systemFont(ofSize: 20)
        userName.backgroundColor = UIColor.secondarySystemFill
        userName.layer.cornerRadius = 15
        userName.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            userName.heightAnchor.constraint(equalToConstant: 60),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
    }
    
    
    func configurePhoneNumberLabel() {
        view.addSubview(phoneNumberLabel)
        phoneNumberLabel.text = "PHONE NUMBER"
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.textColor = .secondaryLabel
        phoneNumberLabel.font = UIFont.preferredFont(forTextStyle: .body)
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 15)
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            phoneNumberLabel.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 30)
        ])
    }
    
    
    func configurePhoneNumber() {
        view.addSubview(phoneNumber)
        phoneNumber.text = "    " + "+254-123-456-789"
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.textColor = .label
        phoneNumber.textAlignment = .natural
        phoneNumber.font = UIFont.preferredFont(forTextStyle: .body)
        phoneNumber.font = UIFont.systemFont(ofSize: 20)
        phoneNumber.backgroundColor = UIColor.secondarySystemFill
        phoneNumber.layer.cornerRadius = 15
        phoneNumber.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            phoneNumber.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 5),
            phoneNumber.heightAnchor.constraint(equalToConstant: 60),
            phoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            phoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
    }
    
    
    func configureEmailLabel() {
        view.addSubview(emailLabel)
        emailLabel.text = "EMAIL ADDRESS"
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = .secondaryLabel
        emailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        emailLabel.font = UIFont.systemFont(ofSize: 15)
        
        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailLabel.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 30)
        ])
    }
    
    
    func configureEmail() {
        view.addSubview(email)
        email.text = "    " + "leonardsangoroh@gmail.com"
        email.translatesAutoresizingMaskIntoConstraints = false
        email.textColor = .label
        email.textAlignment = .natural
        email.font = UIFont.preferredFont(forTextStyle: .body)
        email.font = UIFont.systemFont(ofSize: 20)
        email.backgroundColor = UIColor.secondarySystemFill
        email.layer.cornerRadius = 15
        email.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            email.heightAnchor.constraint(equalToConstant: 60),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
    }
    
}
