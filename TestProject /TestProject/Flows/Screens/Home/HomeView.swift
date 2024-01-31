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
        main
    }
}

private extension HomeView {
    
    var main: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .loading:
                HomeLoadingState()
            case .error(let error):
                ErrorView(errorState: ErrorState(errorMessage: error.localizedDescription))
            case .none:
                personsList
            }
        }
    }
    
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
        .navigationTitle("contact_list".localized)
    }
}

#Preview {
    HomeView(
        viewModel: HomeViewModelImpl(
            personService: PersonServiceImpl(
                executor: NetworkRequestExecutor()
            )
        )
    )
}
