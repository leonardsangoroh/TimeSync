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
    let timeLabel = UILabel()
    let time = UILabel()
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
        configureTimeLabel()
        configureTime()
        configureRightTimeButton()

    }
    
    func configureView(){
        self.view.backgroundColor = UIColor(named: "background_color")
    }
    
    
    func configureProfilePicture() {
        
        view.addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.image = UIImage(named: "empty-contact-image")
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
        
        let timeString = time.text!
        
        // Remove "hrs" from the time string
        let cleanTimeString = timeString.replacingOccurrences(of: " hrs", with: "")
        
        // Create a DateFormatter to parse the time string
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        // Convert the string to a Date object
        guard let time = timeFormatter.date(from: cleanTimeString) else {
            print("Invalid time format")
            return
        }
        
        // Extract the hour component
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        
        DispatchQueue.main.async { [self] in
            if hour >= 8 && hour <= 9 {
                statusAdviceRow.call.tintColor = .systemGreen
                statusAdviceRow.text.tintColor = .systemRed
                statusAdviceRow.mail.tintColor = .systemRed
                statusAdviceRow.meet.tintColor = .systemGreen
            } else if hour >= 10 && hour <= 11 {
                statusAdviceRow.call.tintColor = .systemRed
                statusAdviceRow.text.tintColor = .systemGreen
                statusAdviceRow.mail.tintColor = .systemGreen
                statusAdviceRow.meet.tintColor = .systemRed
            } else if hour >= 12 {
                statusAdviceRow.call.tintColor = .systemRed
                statusAdviceRow.text.tintColor = .systemRed
                statusAdviceRow.mail.tintColor = .systemGreen
                statusAdviceRow.meet.tintColor = .systemGreen
            } else if hour >= 13 && hour <= 15 {
                statusAdviceRow.call.tintColor = .systemRed
                statusAdviceRow.text.tintColor = .systemRed
                statusAdviceRow.mail.tintColor = .systemRed
                statusAdviceRow.meet.tintColor = .systemGreen
            } else if hour >= 16 {
                statusAdviceRow.call.tintColor = .systemRed
                statusAdviceRow.text.tintColor = .systemGreen
                statusAdviceRow.mail.tintColor = .systemGreen
                statusAdviceRow.meet.tintColor = .systemGreen
            } else if hour >= 17 && hour <= 19 {
                statusAdviceRow.call.tintColor = .systemRed
                statusAdviceRow.text.tintColor = .systemGreen
                statusAdviceRow.mail.tintColor = .systemGreen
                statusAdviceRow.meet.tintColor = .systemRed
            } else {
                statusAdviceRow.call.backgroundColor = .systemRed
                statusAdviceRow.text.backgroundColor = .systemRed
                statusAdviceRow.mail.backgroundColor = .systemGreen
                statusAdviceRow.meet.backgroundColor = .systemRed
            }
        }


        
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
    
    
    func configureTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.text = "CONTACT LOCAL TIME"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = .secondaryLabel
        timeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            timeLabel.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 30)
        ])
    }
    
    
    func configureTime() {
        view.addSubview(time)
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textColor = .label
        time.textAlignment = .natural
        time.font = UIFont.preferredFont(forTextStyle: .body)
        time.font = UIFont.systemFont(ofSize: 20)
        time.backgroundColor = UIColor.secondarySystemFill
        time.layer.cornerRadius = 15
        time.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            time.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            time.heightAnchor.constraint(equalToConstant: 60),
            time.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            time.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
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
        let vc = LLMViewController()
        vc.contactName = userName.text
        vc.currentTime = time.text
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
