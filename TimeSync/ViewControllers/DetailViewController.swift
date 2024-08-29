//
//  DetailViewController.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 24/08/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    let profilePicture = UIImageView()
    let userName = UILabel()
    let horizontalLine = UIView()
    let phoneNumberLabel = UILabel()
    let phoneNumber = UILabel()
    let emailLabel = UILabel()
    let email = UILabel()
    let rightTimeButton = TSButton(backgroundColor: .systemGreen, title: "Right Time?")
    let statusAdviceRow = TSButtonRow()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureProfilePicture()
        configureUserName()
        configureStatusAdviceRow()
        configureHorizontalLine()
        configurePhoneNumberLabel()
        configurePhoneNumber()
        configureEmailLabel()
        configureEmail()
        configureRightTimeButton()

    }
    
    func configureView(){
        self.view.backgroundColor = UIColor(named: "background_color")
    }
    
    
    func configureProfilePicture() {
        
        view.addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.image = UIImage(named: "Lee")
        profilePicture.layer.cornerRadius = 75
        profilePicture.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            profilePicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.heightAnchor.constraint(equalToConstant: 150),
            profilePicture.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    func configureUserName() {
        view.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.textColor = .label
        userName.textAlignment = .center
        userName.font = UIFont.boldSystemFont(ofSize: 25)
        

        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 5),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
    }
    
    
    func configureStatusAdviceRow(){
        
        view.addSubview(statusAdviceRow)
        
        statusAdviceRow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusAdviceRow.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 15),
            statusAdviceRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            statusAdviceRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    
    func configureHorizontalLine(){
        horizontalLine.backgroundColor = UIColor.black // Set the color you want
               
        // Add the line to the view hierarchy
        view.addSubview(horizontalLine)
               
        // Disable autoresizing mask constraints
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
               
        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            horizontalLine.heightAnchor.constraint(equalToConstant: 1), // Height of the line (1 point)
            horizontalLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Leading margin
            horizontalLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Trailing margin
            horizontalLine.topAnchor.constraint(equalTo: statusAdviceRow.bottomAnchor, constant: 15)
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
            phoneNumberLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 30)
        ])
    }
    
    
    func configurePhoneNumber() {
        view.addSubview(phoneNumber)
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
    
    
    func configureRightTimeButton(){
        view.addSubview(rightTimeButton)
        rightTimeButton.addTarget(self, action:#selector(promptLLM), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rightTimeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            rightTimeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            rightTimeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            rightTimeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func promptLLM() {
        
    }
    

}
