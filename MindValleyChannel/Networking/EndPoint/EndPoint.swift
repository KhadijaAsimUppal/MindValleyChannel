//
//  EndPoint.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation

/// A protocol defining the essential properties and methods required for constructing an API endpoint.
protocol Endpoint {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    
    /// Constructs and returns a `URLRequest` based on the endpoint's properties.
    /// - Returns: A configured `URLRequest` if the URL is valid, otherwise `nil`.
    func makeRequest() -> URLRequest?
}

//MARK: - Default implementation of 'makeRequest' function
extension Endpoint {
    
    /// Default implementation of the `makeRequest` function for `Endpoint` protocol,
    /// which builds a URL request from the protocol properties.
    func makeRequest() -> URLRequest? {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
