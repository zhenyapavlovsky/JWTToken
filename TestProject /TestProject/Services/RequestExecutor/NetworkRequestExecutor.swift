//
//  NetworkRequestExecutor.swift
//  TestProject
//
//  Created by Roman Sorochak on 25.01.2024.
//

import Foundation
import Combine
import CryptoKit

class NetworkRequestExecutor {
    
    private var token: String = ""
    private let secret = "$SECRET$".toBase64()
    private let baseUrl = "https://opn-interview-service.nn.r.appspot.com"
    private let key: SymmetricKey
    
    init() {
        self.key = SymmetricKey(data: secret.data(using: .utf8)!)
        self.getToken()
    }
    
    private func getToken() {
        
        let header = Header(alg: "HS256", typ: "JWT")
        let payload = Payload(uid: "8008800880088008", identity: "test")
        
        let headerJSONEncoded = try? JSONEncoder().encode(header).urlSafeBase64EncodedString()
        let payloadJSONEncoded = try? JSONEncoder().encode(payload).urlSafeBase64EncodedString()
        
        guard let headerEncoded = headerJSONEncoded, let payloadEncoded = payloadJSONEncoded else {
            fatalError("JSON encoding failed")
        }
        
        let message = "\(headerEncoded).\(payloadEncoded)"
        let signature = HMAC<SHA256>.authenticationCode(for: Data(message.utf8), using: self.key)
        let signatureBase64String = Data(signature).urlSafeBase64EncodedString()
        
        self.token = "\(message).\(signatureBase64String)"
    }
    
    private func createRequest(for url: URL, method: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}

extension NetworkRequestExecutor {
    
    func performRequest<T: Codable>(path: String, method: HTTPMethod) -> AnyPublisher<T, Error> {
            guard let url = URL(string: baseUrl + path) else {
                return Fail(error: ServerError(status: "Invalid URL", error: nil))
                    .eraseToAnyPublisher()
            }
        
        return URLSession.shared.dataTaskPublisher(for: createRequest(for: url, method: method))
                   .tryMap { output in
                       guard let httpResponse = output.response as? HTTPURLResponse,
                             httpResponse.statusCode == 200 else {
                           let serverError = try JSONDecoder().decode(ServerError.self, from: output.data)
                           throw serverError
                       }
                       return output.data
                   }
                   .decode(type: T.self, decoder: JSONDecoder())
                   .receive(on: DispatchQueue.main)
                   .eraseToAnyPublisher()
           }
}

