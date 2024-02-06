//
//  ProfileView.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        main
    }
}

private extension ProfileView {
    
    var main: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .loading:
                ProfileLoadingState()
            case .error(let error):
                ErrorView(errorState: ErrorState(errorMessage: error.localizedDescription), retryAction: {})
            case .none:
                profileContent
            }
        }
    }
    
    var profileContent: some View {
        Form {
            topSection
            middleSection
            bottomSection
        }
    }
    
    var topSection: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                Spacer()
            }
            Text("\(viewModel.person.firstName) \(viewModel.person.lastName)")
                .font(.title2)
        }
    }
    
    var middleSection: some View {
        Section {
            detailRow(label: "age".localized, value: "\(viewModel.person.age)")
            detailRow(label: "gender".localized, value: viewModel.person.gender)
            detailRow(label: "country".localized, value: viewModel.person.country)
        }
    }
    
    var bottomSection: some View {
        Section {
            VStack(spacing: 15) {
                createButtonWithIcon(text: "send_a_message".localized, icon: "message")
                createButtonWithIcon(text: "call".localized, icon: "phone")
            }
        }
    }
    
    func detailRow(label: String, value: String) -> some View {
        Button(action: {}) {
            HStack {
                Text(label)
                Spacer()
                Text(value)
                    .foregroundColor(.gray)
                    .font(.callout)
                    .frame(alignment: .leading)
            }
        }
    }
    
    func createButtonWithIcon(text: String, icon: String) -> some View {
        Button(action: {}) {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: icon)
                    .foregroundColor(.blue)
            }
        }
    }
}

//#Preview {
//    ProfileView()
//}
