//
//  NetworkError.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

enum NetworkError: Error {
    case badRequest
    case decodingError
    case noInternet
    case unknownError(String)
}
