//
//  NylasService.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 27/08/2024.
//

import Foundation

class NylasService {
    
    //creates singleton instance of NylasService ensuring only one of its instance is used throughout the app
    static let shared = NylasService()
    
    private let apiKey = "nyk_v0_uwBDKf5oGvxYiuMbwU4Nv9szBFBhTpSx64RSfUalOcabAEjbt2HwMMxzedQvcbuM"
    private static let grantID = "1100d579-b94a-408b-94b7-ec53085d46c3"
    private let baseUrl = "https://api.us.nylas.com/v3/grants/\(grantID)/contacts"
    
    //prevents creation of instances outside the singleton pattern
    private init(){}
    
    
    func getContacts(completion: @escaping (Result<[Contact], Error>) -> Void)-> Void{
        
        let endpoint = baseUrl
        
        guard let url = URL(string: endpoint) else {
            print("Empty URL")
            return
        }
        
        let token = "Bearer \(apiKey)"
        var request = URLRequest(url:url)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": token,
            "Content-Type": "application/json"
             
        ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Unexpected response code generated")
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(error!))
                return
            }
            
            do {
                print("Data received: \(data.count) bytes")
                let decoder = JSONDecoder()
                let contactsMetaData = try decoder.decode(Contacts.self, from: data)
                let contacts = contactsMetaData.data
                
                completion(.success(contacts))
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(.failure(error))
                // for more detail, get the raw data
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Raw JSON data: \(jsonString)")
//                }
            }
            
            
        }
        task.resume()
        
    }
    
}
