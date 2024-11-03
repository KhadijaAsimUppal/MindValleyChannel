//
//  NetworkService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation
import Combine

/// A service class responsible for making network requests.
class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

//MARK: - Network Request
extension NetworkService {

    /// Sends a request to the specified endpoint and decodes the response to the specified type.
    /// - Parameters:
    ///   - endpoint: The endpoint conforming to `Endpoint` protocol that defines the request.
    ///   - decodingType: The type conforming to `Decodable` that the response should be decoded into.
    /// - Returns: A publisher that either emits a decoded object of type `T` or a `NetworkError`.
    func request<T: Decodable>(_ endpoint: Endpoint, decodingType: T.Type) -> AnyPublisher<T, NetworkError> {
        
        // Check for internet connectivity
        guard NetworkReachability.shared.isConnected else {
            return Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        }
        
        // Attempt to create a URL request from the provided endpoint
        guard let urlRequest = endpoint.makeRequest() else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }
        
        // Perform the network request and decode the response data
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                // Verify the response code is 200, otherwise throw an error
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw NetworkError.unknownError("Invalid response code.")
                }
                return data
            }
            // Decode the response data into the specified type `T`
            .decode(type: T.self, decoder: JSONDecoder())
            // Map any decoding error to a `NetworkError` for error handling
            .mapError { _ in NetworkError.decodingError }
            .eraseToAnyPublisher()
    }
}

