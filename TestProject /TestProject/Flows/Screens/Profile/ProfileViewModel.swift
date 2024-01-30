//
//  ProfileViewModel.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var output = String()
    @Published var loadingState = false
    
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

//class ProfileViewModelImpl: ProfileViewModel {
//    
//    private var cancellables = Set<AnyCancellable>()
//    
////    func getPersonDetails() {
////           self.loadingState = true
////        personService
////            .getPersonDetails(id: person.id)
////            .sink { [weak self] completion in
////                guard case .failure(let error) = completion else { return }
////                self?.output = error.localizedDescription
////                self?.loadingState = false
////            } receiveValue: { [weak self] personDetail in
////                self?.person = personDetail
////            }
////            .store(in: &cancellables)
////    }
//}

