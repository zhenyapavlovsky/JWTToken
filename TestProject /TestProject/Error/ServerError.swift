//
//  ServerError.swift
//  TestProject
//
//  Created by Roman Sorochak on 30.01.2024.
//

import Foundation

struct ServerError: Codable, Error {
    
    let code: Int
    let message: String
}
