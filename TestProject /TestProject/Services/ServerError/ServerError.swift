//
//  ServerError.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import Foundation

struct ServerError: Codable, Error {
    
    let status: String
    let error: ErrorDetail?

    struct ErrorDetail: Codable {
        let message: String
    }

    var localizedDescription: String {
        return error?.message ?? "Unknown error"
    }
}
