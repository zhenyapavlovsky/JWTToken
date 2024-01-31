//
//  ProfileViewModel.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var output = String()
    @Published var loadingState: LoadingState = .none
    
    enum Result {
        case navigationBack
    }
    
    var onResult: ((Result) -> Void)?
    var person: UserDetails
    let personService: PersonService
    
    init(person: UserDetails, personDetiils: PersonService) {
        self.person = person
        self.personService = personDetiils
    }
    
    func navigateBack() {
        onResult?(.navigationBack)
    }
}


