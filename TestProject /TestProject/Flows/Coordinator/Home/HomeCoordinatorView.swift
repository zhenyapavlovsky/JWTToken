//
//  HomeCoordinatorView.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import SwiftUI
import SwiftUINavigation

struct HomeCoordinatorView: View {
    
    @ObservedObject var coordinator: HomeCoordinator
    
    var body: some View {
        NavigationView {
            ZStack {
                HomeView(viewModel: coordinator.homeViewModel)
                
                NavigationLink(
                    unwrapping: $coordinator.route,
                    case: /HomeCoordinator.Route.profile,
                    destination: { (coordinator: Binding<ProfileCoordinator>) in
                        ProfilesCoordinatorView(
                            coordinator: coordinator.wrappedValue
                        ).navigationBarBackButtonHidden(false)
                    }, onNavigate: { _ in }) {}
            }
        }
    }
}
