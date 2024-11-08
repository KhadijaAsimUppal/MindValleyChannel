//
//  ChannelsService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 03/11/2024.
//

import Combine
import Foundation

/// A service class responsible for fetching channels data from the API.
class ChannelsService {
    
    private let networkService: NetworkService
 
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches channels data from the API. Fetches channels data from the API with fallback to Core Data if the network request fails.
    /// - Returns: A publisher that emits a `ChannelsModel` on success or a `NetworkError` on failure.
    func fetchChannels() -> AnyPublisher<[ChannelModel], Never> {
        return networkService.request(MindValleyAPI.getChannels, decodingType: ChannelsModel.self)
            .map { $0.data.channels }
            .handleEvents(receiveOutput: { channels in
                self.saveToCoreData(channels: channels)
            })
            .catch { _ in
                Just(CoreDataManager.shared.fetchChannels())
            }
            .eraseToAnyPublisher()
    }
    
    /// Saves chansnel model to coredata
    private func saveToCoreData(channels: [ChannelModel]) {
        channels.forEach { CoreDataManager.shared.saveChannel($0) }
        CoreDataManager.shared.saveContext() // Only call saveContext once after all inserts are done
    }
}
