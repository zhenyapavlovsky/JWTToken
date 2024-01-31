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
    @Published var loadingState: LoadingState = .none
    
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
        self.loadingState = .loading
        personService.getPersons()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.loadingState = .error(error: error)
                case .finished:
                    self?.loadingState = .none
                }
            }, receiveValue: { [weak self] userList in
                self?.loadPersonDetails(ids: userList.data)
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
            self?.loadingState = .none
        }, receiveValue: { [weak self] userDetails in
            self?.userDetails = userDetails
        })
        .store(in: &cancellables)
    }
}
