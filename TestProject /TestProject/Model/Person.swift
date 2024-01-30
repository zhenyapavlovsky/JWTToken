//
//  per.swift
//  TestProject
//
//  Created by Roman Sorochak on 28.01.2024.
//
//

import Foundation

struct UserList: Codable {
    
    let data: [String]
    let status: String
    
}


struct UserDetails: Codable, Identifiable, Equatable, Hashable  {
    
    let id: String
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let country: String
}


struct UserDetailsResponse: Codable {
    
    let status: String
    let data: UserDetails
}
