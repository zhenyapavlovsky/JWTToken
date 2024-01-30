//
//  HomeViewModel.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var firstNames = [String]()
    @Published var persons = [UserDetails]()
    @Published var errorMessage: String?
    //  @Published var output = String()
    @Published var loadingState = false
    @Published var userDetails = [UserDetails]()
    
    enum Result {
        case onProfileSelected(person: UserDetails)
    }
    
    var onResult: ((Result) -> Void)?
    
    func selectProfileItem(person: UserDetails) {
        onResult?(.onProfileSelected(person: person))
    }
    
    func getPersons() {}
}

class HomeViewModelImpl: HomeViewModel {
    
    private let personService: PersonService
    private var cancellables = Set<AnyCancellable>()
    
    init(personService: PersonService) {
        self.personService = personService
        super.init()
        getPersons()
    }
    
    override func getPersons() {
        self.loadingState = true
        personService
            .getPersons()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error loading persons: \(error)")
                    self?.errorMessage = error.localizedDescription
                    self?.loadingState = false
                case .finished:
                    print("Finished loading persons")
                }
            } receiveValue: { [weak self] userList in
                print("Received person IDs: \(userList.data)")
                self?.loadPersonDetails(ids: userList.data)
            }
            .store(in: &cancellables)
    }
    
    private func loadPersonDetails(ids: [String]) {
        self.loadingState = true
        self.firstNames = []

        let detailsPublisher = ids.publisher
            .flatMap { id in
                self.personService.getPersonDetails(id: id)
                    .catch { error -> Empty<UserDetails, Never> in
                        print("Error fetching details for ID \(id): \(error)")
                        return Empty()
                    }
            }
            .collect()
            .receive(on: DispatchQueue.main)

        detailsPublisher.sink(receiveCompletion: { [weak self] _ in
            self?.loadingState = false
        }, receiveValue: { [weak self] userDetails in
            print("Received user details: \(userDetails)")
            self?.firstNames = userDetails.map { $0.firstName }.filter { $0 != "Unknown" }
        })
        .store(in: &cancellables)
    }
}
