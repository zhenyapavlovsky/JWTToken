//
//  ErrorView.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import SwiftUI

struct ErrorView: View {
    
    let errorState: ErrorState
    
    var body: some View {
        VStack {
            detailError
        }
    }
}

private extension ErrorView {
    
    var textError: some View {
        VStack {
            Text(errorState.errorMessage)
                .font(.system(size: 18, weight: .bold))
                .bold()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
        }
        .frame(width: 300, alignment: .center)
    }
    
    var errorImage: some View {
        Image.errorImage
            .resizable()
            .frame(width: 100, height: 100)
    }
    
    var detailError: some View {
        VStack(spacing: 40) {
            errorImage
            textError
            Spacer()
                .createRertryErrorButton(text: "Try again", action: {})
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            errorState: ErrorState(
                errorMessage: "Something went wrong"
            )
        )
    }
}
