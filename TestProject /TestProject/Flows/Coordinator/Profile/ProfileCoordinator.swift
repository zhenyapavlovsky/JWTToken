//
//  ProfileCoordinator.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import Foundation
import SwiftUINavigation

class ProfileCoordinator: ObservableObject {
    
    enum Result {
        case navigationBack
    }
    
    var onResult: ((Result) -> Void)?
    var profileViewModel: ProfileViewModel
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        profileViewModel.onResult = { [weak self] result in
            switch result {
            case .navigationBack:
                self?.onResult?(.navigationBack)
            }
        }
    }
}

