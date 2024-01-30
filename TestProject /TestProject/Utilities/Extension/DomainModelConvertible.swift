//
//  DomainModelConvertible.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import Foundation

protocol DomainModelConvertible {
    associatedtype DomainModel
    func toDomainModel() -> DomainModel
}
