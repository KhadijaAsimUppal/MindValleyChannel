//
//  MindValleyAPI.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation

enum MindValleyAPI: Endpoint {
    
    case getEpisodes
    case getChannels
    case getCategories
    
    var baseURL: URL {
        guard let url = URL(string: "https://pastebin.com/raw") else {fatalError("Invalid Base URL.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getEpisodes:
            return "/z5AExTtw"
        case .getChannels:
            return "/Xt12uVhM"
        case .getCategories:
            return "/A0CgArX3"
        }
    }
    
    var method: HTTPMethod {
        return switch self {
        case .getEpisodes, .getChannels, .getCategories:
                .get
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
