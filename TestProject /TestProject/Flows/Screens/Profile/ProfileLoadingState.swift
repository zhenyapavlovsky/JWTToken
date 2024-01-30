//
//  ProfileLoadingState.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import SwiftUI

struct ProfileLoadingState: View {
    var body: some View {
        Form {
            topSection
            middleSection
            bottomSection
        }
    }
}

private extension ProfileLoadingState {
    
    var topSection: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .frame(width: 100, height: 100)
                Spacer()
            }
            ShimmerView()
        }
    }
    
    var middleSection: some View {
        Section {
            ForEach(0...2, id: \.self) { _ in
                detailRow()
            }
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
    
    func detailRow() -> some View {
        Button(action: {}) {
            HStack {
                ShimmerView()
                
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


#Preview {
    ProfileLoadingState()
}
