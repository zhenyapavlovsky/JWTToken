//
//  HomeViewModel.swift
//  TestProject
//
//  Created by Roman Sorochak on 24.01.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var userDetails = [UserDetails]()
    @Published var errorMessage: String?
    @Published var loadingState = false
    @Published var errorState: ErrorState?
    
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
    
    private func handleError(_ error: Error) {
        let errorMessage: String
        if let serverError = error as? ServerError {
            errorMessage = serverError.status == "error" ? (serverError.error?.message ?? "Something went wrong") : "Unexpected error"
        } else {
            errorMessage = error.localizedDescription
        }
        self.errorState = ErrorState(
            errorMessage: errorMessage,
            retryAction: {
                self.getPersons()
            }
        )
    }
    
    override func getPersons() {
        self.loadingState = true
        personService.getPersons()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleError(error)
                    self?.loadingState = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] userList in
                self?.loadPersonDetails(ids: userList.data) // Використання масиву 'data' з 'UserList'
            })
            .store(in: &cancellables)
    }
    
    private func loadPersonDetails(ids: [String]) {
        let detailsPublisher = ids.publisher
            .flatMap { [unowned self] id in
                self.personService.getPersonDetails(id: id)
                    .map { $0.data } // Використання поля 'data' з 'UserDetailsResponse'
                    .catch { _ in Empty<UserDetails, Never>() }
            }
            .collect()
            .receive(on: DispatchQueue.main)
        
        detailsPublisher.sink(receiveCompletion: { [weak self] _ in
            self?.loadingState = false
        }, receiveValue: { [weak self] userDetails in
            self?.userDetails = userDetails
        })
        .store(in: &cancellables)
    }
}
