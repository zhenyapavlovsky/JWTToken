//
//  TestProjectApp.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import SwiftUI

@main
struct TestProjectApp: App {
    var body: some Scene {
        WindowGroup {
            HomeCoordinatorView(
                coordinator: .init(
                    homeViewModel: HomeViewModelImpl(
                        personService: PersonServiceImpl(
                            executor: NetworkRequestExecutor()
                        )
                    )
                )
            )
        }
    }
}
