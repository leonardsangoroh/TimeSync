//
//  Contact.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 25/08/2024.
//

import UIKit


struct Contact: Decodable {
    //
    let emails: [Email]?
    //
    let givenName: String
    let grantId: String
    let groups: [Group]
    //
    let id: String
    let imAddresses: [String]
    let object: String
    let phoneNumbers: [PhoneNumber]
    let physicalAddresses: [String]
    //
    let pictureURL: String
    let surname: String
    let source: String
    let webPages: [String]
    let updatedAt: Int
//    let country: String?
//    let timeZone: String?
//    let localTime: String
    
    
    enum CodingKeys: String, CodingKey {
        case emails
        case givenName = "given_name"
        case grantId = "grant_id"
        case groups, id
        case imAddresses = "im_addresses"
        case object
        case phoneNumbers = "phone_numbers"
        case physicalAddresses = "physical_addresses"
        case pictureURL = "picture_url"
        case surname
        case source
        case webPages = "web_pages"
        case updatedAt = "updated_at"
    }
}


struct Group: Decodable {
    let id: String
}


struct Email: Decodable {
    let email: String
    //let type: String
}


struct PhoneNumber: Decodable {
    let number: String
    let type: String?
}
