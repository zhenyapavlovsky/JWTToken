//
//  NavigationLink.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import SwiftUINavigation
import SwiftUI

extension NavigationLink {
    
    init<Enum, Case, WrappedDestination> (
        unwrapping enum: Binding<Enum?>,
        case casePath: CasePath<Enum, Case>,
        @ViewBuilder destination: @escaping (Binding<Case>) -> WrappedDestination
    ) where Destination == WrappedDestination?, Label == EmptyView {
        self.init(
            unwrapping: `enum`.case(casePath),
            destination: destination,
            onNavigate: { _ in },
            label: {}
        )
    }
}

