//
//  ErrorState.swift
//  TestProject
//
//  Created by Roman Sorochak on 30.01.2024.
//

import Foundation

struct ErrorState {
    
    var buttonMessage: String = "Try again"
    let errorMessage: String
    let retryAction: () -> Void
}
