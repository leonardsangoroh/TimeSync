//
//  Contacts.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 28/08/2024.
//

import Foundation

struct Contacts: Decodable {
    let requestId: String
    let data: [Contact]
    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case data
    }
}
