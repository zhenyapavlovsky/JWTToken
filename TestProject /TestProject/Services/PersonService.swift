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
    
    func getPersons() -> AnyPublisher<UserList, Error>
    func getPersonDetails(id: String) -> AnyPublisher<UserDetails, Error>
}

final class PersonServiceImpl: PersonService {
    
    let executor: NetworkRequestExecutor
    private var cancellable: Set<AnyCancellable> = []
    
    init(executor: NetworkRequestExecutor) {
        self.executor = executor
    }
    
    func getPersons() -> AnyPublisher<UserList, Error> {
        executor.performRequest(path: "/list", method: .get)
    }
    
    func getPersonDetails(id: String) -> AnyPublisher<UserDetails, Error> {
        executor.performRequest(path: "/get/\(id)", method: .get)
    }
}


