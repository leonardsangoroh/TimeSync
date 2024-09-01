//
//  LLMViewController.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 01/09/2024.
//

import UIKit
import GoogleGenerativeAI

class LLMViewController: UIViewController {
    
    var currentTime: String!
    var contactName: String!
    
    let geminiLogo = UIImageView()
    let promptMessage = UILabel()
    let messageInput = UITextField()
    let responseOutput = UILabel()
    let sendButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        Task {
//            await firstPrompt()
//        }
        
        configureView()
        configureGeminiImageView()
        configurePromptMessage()
        configureMessageInput()
        configureSendButton()
        
    }
    
    
    func configureView(){
        view.backgroundColor = UIColor(named: "background_color")
        
    }
    
    
    func configureGeminiImageView(){
        view.addSubview(geminiLogo)
        geminiLogo.translatesAutoresizingMaskIntoConstraints = false
        geminiLogo.image = UIImage(named: "gemini-logo")
        
        NSLayoutConstraint.activate([
            geminiLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            geminiLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            geminiLogo.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.5),
            geminiLogo.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func configurePromptMessage(){
        view.addSubview(promptMessage)
        promptMessage.translatesAutoresizingMaskIntoConstraints = false
        promptMessage.text = "Provide more context for the best \n communication channel \n with \(contactName!)...".uppercased()
        promptMessage.textColor = .label
        promptMessage.textAlignment = .center
        promptMessage.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            promptMessage.topAnchor.constraint(equalTo: geminiLogo.bottomAnchor, constant: 20),
            promptMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            promptMessage.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    
    
    func configureMessageInput(){
        view.addSubview(messageInput)
        messageInput.translatesAutoresizingMaskIntoConstraints = false
        messageInput.borderStyle = .roundedRect
        messageInput.backgroundColor = .clear
        messageInput.autocorrectionType = .yes
        messageInput.spellCheckingType = .yes
        messageInput.layer.borderColor = UIColor.black.cgColor
        messageInput.layer.cornerRadius = 10
        messageInput.layer.borderWidth = 2
        messageInput.textColor = .label
        messageInput.adjustsFontSizeToFitWidth = true
        messageInput.minimumFontSize = 12
        messageInput.placeholder = "Message Gemini"
        
        NSLayoutConstraint.activate([
            messageInput.topAnchor.constraint(equalTo: promptMessage.bottomAnchor, constant: 20),
            messageInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            messageInput.heightAnchor.constraint(equalToConstant: 50),
            messageInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
    }
    
    
    func configureSendButton(){
        view.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = .black
        sendButton.layer.cornerRadius = 8
        sendButton.addTarget(self, action:#selector(sendPrompt), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            sendButton.leadingAnchor.constraint(equalTo: messageInput.trailingAnchor, constant: 5),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            sendButton.topAnchor.constraint(equalTo: promptMessage.bottomAnchor, constant: 20),
            sendButton.heightAnchor.constraint(equalTo:messageInput.heightAnchor)
        ])
    }
    
    
    func configureResponseOutput() {
        view.addSubview(responseOutput)
        responseOutput.translatesAutoresizingMaskIntoConstraints = false
        responseOutput.textColor = .label
        responseOutput.textAlignment = .natural
        responseOutput.numberOfLines = .max
        responseOutput.font = UIFont.preferredFont(forTextStyle: .body)
        responseOutput.font = UIFont.systemFont(ofSize: 20)
        responseOutput.backgroundColor = UIColor.secondarySystemFill
        responseOutput.layer.cornerRadius = 15
        responseOutput.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            responseOutput.topAnchor.constraint(equalTo: messageInput.bottomAnchor, constant: 30),
            responseOutput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            responseOutput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            responseOutput.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
    }
    
    
    @objc func sendPrompt(){
        Task {
            await executeSendPrompt()
        }
    }
    
    
    func executeSendPrompt () async {
        let generativeModel =
          GenerativeModel(
            // Specify a Gemini model appropriate for your use case
            name: "gemini-1.5-flash",
            // Access your API key from your on-demand resource .plist file (see "Set up your API key"
            // above)
            apiKey: GeminiAPIKey.default
          )
        
        print("This is the current time: " + currentTime!)

        let prompt = """
            Given the current time: \(currentTime!), and the following timing rules:

            - 6 AM - 9 AM: Early morning (e.g., email, schedule meetings)
            - 9 AM - 12 PM: Morning work hours (e.g., call, text, email, meetings)
            - 12 PM - 3 PM: Early afternoon (e.g., call, text, email, meetings)
            - 3 PM - 6 PM: Late afternoon (e.g., text, email, meetings)
            - 6 PM - 9 PM: Early evening (e.g., text, email)
            - 9 PM - 6 AM: Nighttime (e.g., email, schedule meetings)

            Please advise on the best communication method (call, text, email, or meeting request) based on this information and the following additional context: \(messageInput.text). If you think there's need to break precedence on communication method based on urgency in some cases, feel free to do so.

            Provide your guidance in 40 words, focusing only on the information provided. No markdown syntax; ensure proper formatting in plain text.
        """

        let response = prompt
        
        let nonOptionalResponse = try! await generativeModel.generateContent(response)
        
        if let text = nonOptionalResponse.text {
            DispatchQueue.main.async {
                self.responseOutput.text = text
                self.configureResponseOutput()
            }
        }
    }
}
