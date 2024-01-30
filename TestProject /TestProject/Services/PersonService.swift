//
//  PersonService.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import Foundation
import Combine
import CryptoKit

protocol PersonService {
    
    func getPersons() -> AnyPublisher<UserListResponse, Error>
    func getPersonDetails(id: String) -> AnyPublisher<UserDetailsResponse, Error>
}

final class PersonServiceImpl: PersonService {
    
    let executor: NetworkRequestExecutor
    private var cancellable: Set<AnyCancellable> = []
    
    init(executor: NetworkRequestExecutor) {
        self.executor = executor
    }
    
    func getPersons() -> AnyPublisher<UserListResponse, Error> {
        executor.performRequest(path: "/lists", method: .get)
    }
    
    func getPersonDetails(id: String) -> AnyPublisher<UserDetailsResponse, Error> {
        executor.performRequest(path: "/get/\(id)", method: .get)
    }
}


