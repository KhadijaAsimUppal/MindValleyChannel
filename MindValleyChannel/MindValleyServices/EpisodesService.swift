//
//  EpisodesService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//
import Combine

/// A service class responsible for fetching episode data from the API.
class EpisodeService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches episodes data from the API.
    /// - Returns: A publisher that emits an `EpisodesModel` on success or a `NetworkError` on failure.
    func fetchEpisodes() -> AnyPublisher<EpisodesModel, NetworkError> {
        return networkService.request(MindValleyAPI.getEpisodes, decodingType: EpisodesModel.self)
    }
}

