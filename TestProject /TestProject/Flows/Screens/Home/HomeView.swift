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
            } else if let errorState = viewModel.errorState {
                ErrorView(errorState: errorState)
            } else {
                personsList
            }
        }
        .navigationTitle("contact_list".localized)
    }
}

private extension HomeView {
    
    var personsList: some View {
        List(viewModel.userDetails, id: \.self) { per in
            Button(action: {
                viewModel.selectProfileItem(person: per)
            }) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 5)
                    Text(per.firstName)
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
