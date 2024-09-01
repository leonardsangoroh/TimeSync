//
//  Gemini_APIKey.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 01/09/2024.
//

import Foundation

enum GeminiAPIKey {
  // Fetch the API key from `GenerativeAI-Info.plist`
  static var `default`: String {
      guard let filePath = Bundle.main.path(forResource: "DebugKeys", ofType: "plist")
      else {
        fatalError("Couldn't find file 'DebugKeys.plist'.")
      }
      let plist = NSDictionary(contentsOfFile: filePath)
      guard let value = plist?.object(forKey: "GEMINI_API_KEY") as? String else {
        fatalError("Couldn't find key 'API_KEY' in 'DebugKeys.plist'.")
      }
      if value.starts(with: "_") {
        fatalError(
          "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
        )
      }
      return value
  }
}
