//
//  LLMViewController.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 01/09/2024.
//

import UIKit
import GoogleGenerativeAI

class LLMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Task {
            await firstPrompt()
        }
    }
    
    func firstPrompt () async {
        let generativeModel =
          GenerativeModel(
            // Specify a Gemini model appropriate for your use case
            name: "gemini-1.5-flash",
            // Access your API key from your on-demand resource .plist file (see "Set up your API key"
            // above)
            apiKey: GeminiAPIKey.default
          )

        let prompt = "Write a story about a magic backpack."
        let response = try! await generativeModel.generateContent(prompt)
        if let text = response.text {
          print(text)
        }
    }
}
