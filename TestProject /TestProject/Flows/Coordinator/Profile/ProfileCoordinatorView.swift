//
//  ProfileCoordinatorView.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import SwiftUI
import SwiftUINavigation

struct ProfilesCoordinatorView: View {
    
    @ObservedObject var coordinator: ProfileCoordinator
    
    var body: some View {
        NavigationView {
            ZStack {
                ProfileView(viewModel: coordinator.profileViewModel)
            }
        }
    }
}
