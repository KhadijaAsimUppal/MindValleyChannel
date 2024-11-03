//
//  EndPoint.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation

protocol Endpoint {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    
    func makeRequest() -> URLRequest?
}

extension Endpoint {
    
    func makeRequest() -> URLRequest? {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
//        if let parameters = parameters {
//            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        }
        return request
    }
}
