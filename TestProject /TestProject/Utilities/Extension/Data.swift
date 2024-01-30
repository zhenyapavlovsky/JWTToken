//
//  Data.swift
//  TestProject
//
//  Created by Roman Sorochak on 27.01.2024.
//

import Foundation

extension Data {
    
    func urlSafeBase64EncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
