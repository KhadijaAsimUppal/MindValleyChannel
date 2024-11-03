//
//  NetworkService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation
import Combine

class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, decodingType: T.Type) -> AnyPublisher<T, NetworkError> {
        // Check for internet connectivity
        guard NetworkReachability.shared.isConnected else {
            return Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        }
        
        // Create URL request
        guard let urlRequest = endpoint.makeRequest() else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw NetworkError.unknownError("Invalid response code.")
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder()) // Decode directly to the expected type
            .mapError { _ in NetworkError.decodingError } // Map all errors to decoding error for simplicity
            .eraseToAnyPublisher()

    }

}

