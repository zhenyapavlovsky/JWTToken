//
//  LoadingState.swift
//  TestProject
//
//  Created by Roman Sorochak on 31.01.2024.
//

import Foundation

enum LoadingState {
    
    case none
    case loading
    case error(error: Error)
}

extension LoadingState {
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}
