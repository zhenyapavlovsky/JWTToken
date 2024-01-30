//
//  HomeLoadingState.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import SwiftUI

struct HomeLoadingState: View {
    
    var body: some View {
        personsList
    }
}

private extension HomeLoadingState {
    
    var personsList: some View {
        List {
            ForEach(0...20, id: \.self) { _ in
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 5)
                    ShimmerView()
                }
            }
        }
        .navigationTitle("contact_list".localized)
    }
}

#Preview {
    HomeLoadingState()
}
