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
                self.saveToCoreData(episodesModel: episodesModel)
            })
            .map { $0.data.media }
            .catch { _ in
                // On failure, fetch episodes from Core Data
                Just(CoreDataManager.shared.fetchEpisodes())
            }
            .eraseToAnyPublisher()
    }
    
    /// Saves episodes model to coredata asynchronously
    private func saveToCoreData(episodesModel: EpisodesModel) {
        DispatchQueue.global(qos: .background).async {
            episodesModel.data.media.forEach { episode in
                CoreDataManager.shared.saveEpisode(episode)
            }
        }
    }
}

