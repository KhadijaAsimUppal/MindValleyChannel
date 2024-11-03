//
//  ChannelsService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 03/11/2024.
//

import Combine

/// A service class responsible for fetching channels data from the API.
class ChannelsService {
    
    private let networkService: NetworkService
 
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches channels data from the API.
    /// - Returns: A publisher that emits a `ChannelsModel` on success or a `NetworkError` on failure.
    func fetchChannels() -> AnyPublisher<ChannelsModel, NetworkError> {
        return networkService.request(MindValleyAPI.getChannels, decodingType: ChannelsModel.self)
    }
}
