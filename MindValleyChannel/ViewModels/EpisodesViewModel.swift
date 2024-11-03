//
//  EpisodesViewModel.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation
import Combine

class EpisodesViewModel: ObservableObject {
    
    @Published var episodes: [EpisodeModel] = []
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let episodeService: EpisodeService
    
    init() {
        let networkService = NetworkService()
        self.episodeService = EpisodeService(networkService: networkService)
    }
    
    func fetchEpisodes() {
        episodeService.fetchEpisodes()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] episodesModel in
                self?.episodes = episodesModel.data.media
            })
            .store(in: &cancellables)
    }
}
