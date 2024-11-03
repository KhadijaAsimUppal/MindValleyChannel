//
//  NetworkServiceProrcol.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Combine

protocol NetworkServiceProtocol {
    
    func request<T: Decodable>(_ endpoint: Endpoint, decodingType: T.Type) -> AnyPublisher<T, NetworkError>
}

