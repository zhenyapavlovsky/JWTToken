//
//  RuntimeError.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import Foundation

struct RuntimeError: Error {
    
    let message: String
    init(_ message: String) {
        self.message = message
    }
}
