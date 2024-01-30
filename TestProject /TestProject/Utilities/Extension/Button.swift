//
//  Button.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import Foundation
import SwiftUI

extension View {
    
    func createRertryErrorButton(text: String, action: (() -> Void)?) -> some View {
        VStack {
            Button(action: {
                action?()}
            ){
                Text(text)
                    .font(.system( size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(width: 330, height: 70)
            .background(Color.errorButton)
            .cornerRadius(15)
        }
    }
}
