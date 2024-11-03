//
//  ChannelsService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 03/11/2024.
//

import Combine

/// A service class responsible for fetching categories data from the API.
class CategoriesService {
    
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches categories data from the API.
    /// - Returns: A publisher that emits a `CategoriesModel` on success or a `NetworkError` on failure.
    func fetchCategories() -> AnyPublisher<CategoriesModel, NetworkError> {
        return networkService.request(MindValleyAPI.getCategories, decodingType: CategoriesModel.self)
    }
}
