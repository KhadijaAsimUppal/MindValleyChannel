//
//  EpisodesService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Combine

class EpisodeService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchEpisodes() -> AnyPublisher<EpisodesModel, NetworkError> {
        return networkService.request(MindValleyAPI.getEpisodes, decodingType: EpisodesModel.self)
    }
}
