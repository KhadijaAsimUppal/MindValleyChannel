//
//  EpisodesService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Combine
import Foundation

/// A service class responsible for fetching episode data from the API.
class EpisodeService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches episodes data from the API with a fallback to Core Data if the network request fails.
    /// - Returns: A publisher that emits `[EpisodeModel]` on success from either the network or Core Data.
    func fetchEpisodes() -> AnyPublisher<[EpisodeModel], Never> {
        return networkService.request(MindValleyAPI.getEpisodes, decodingType: EpisodesModel.self)
            .handleEvents(receiveOutput: { episodesModel in
                // Save to Core Data asynchronously after returning data to the UI
                self.saveToCoreData(episodes: episodesModel)
            })
            .map { $0.data.media }
            .catch { _ in
                // On failure, fetch episodes from Core Data
                Just(CoreDataManager.shared.fetchEpisodes())
            }
            .eraseToAnyPublisher()
    }
    
    /// Saves episodes model to coredata    
    private func saveToCoreData(episodes: EpisodesModel) {
        episodes.data.media.forEach { CoreDataManager.shared.saveEpisode($0) }
        CoreDataManager.shared.saveContext() // Only call saveContext once after all inserts are done
    }
}

