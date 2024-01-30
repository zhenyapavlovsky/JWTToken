//
//  HomeView.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.loadingState {
                HomeLoadingState()
            } else {
                personsList
            }
        }
        .navigationTitle("contact_list".localized)
    }
}

private extension HomeView {
    
    var personsList: some View {
        List(viewModel.firstNames, id: \.self) { firstName in
            Button(action: {
                // Обробка вибору користувача
            }) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 5)
                    Text(firstName)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .foregroundColor(Color.black)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModelImpl(personService: PersonServiceImpl(executor: NetworkRequestExecutor())))
}
