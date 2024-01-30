//
//  HomeCoordinator.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import Foundation
import SwiftUI

class HomeCoordinator: ObservableObject {
    
    enum Route {
        case profile(coordinator: ProfileCoordinator)
    }
    
    @Published var route: Route?
    
    var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        homeViewModel.onResult = {[weak self] result in
            switch result {
            case .onProfileSelected(let firstName):
                self?.routeToProfileView(person: firstName)
            }
        }
    }
    
    func routeToProfileView(person: UserDetails) {
        let profileCoordinator = ProfileCoordinator(
            profileViewModel: ProfileViewModel(
                person: person,
                personDetiils: PersonServiceImpl(
                    executor: NetworkRequestExecutor()
                )
            )
        )
        
        profileCoordinator.onResult = { result in
            switch result {
            case .navigationBack:
                self.route = nil
            }
        }
        route = .profile(coordinator: profileCoordinator)
    }
}
