//
//  ChannelsService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 03/11/2024.
//

import Combine
import Foundation

/// A service class responsible for fetching categories data from the API.
class CategoriesService {
    
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches categories data from the API with fallback to Core Data if the network request fails.
    /// - Returns: A publisher that emits a `CategoriesModel` on success or a `NetworkError` on failure.
    func fetchCategories() -> AnyPublisher<[CategoryModel], Never> {
        return networkService.request(MindValleyAPI.getCategories, decodingType: CategoriesModel.self)
            .map { $0.data.categories }
            .handleEvents(receiveOutput: { categories in
                self.saveToCoreData(categories: categories)
            })
            .catch { _ in
                Just(CoreDataManager.shared.fetchCategories())
            }
            .eraseToAnyPublisher()
    }
    
    /// Saves categories to coredata
    private func saveToCoreData(categories: [CategoryModel]) {
        categories.forEach { CoreDataManager.shared.saveCategory($0) }
        CoreDataManager.shared.saveContext() // Only call saveContext once after all inserts are done
    }
}

