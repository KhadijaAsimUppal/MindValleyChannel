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
    @Published var channels: [ChannelModel] = []
    
    @Published var episodesErrorMessage: String?
    @Published var channelsErrorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let episodeService: EpisodeService
    private let channelsService: ChannelsService
    
    init() {
        let networkService = NetworkService()
        self.episodeService = EpisodeService(networkService: networkService)
        self.channelsService = ChannelsService(networkService: networkService)
    }
    
    func fetchEpisodes() {
        episodeService.fetchEpisodes()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.episodesErrorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] episodesModel in
                self?.episodes = episodesModel.data.media
            })
            .store(in: &cancellables)
    }
    
    func fetchChannels() {
        channelsService.fetchChannels()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.channelsErrorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] channelsModel in
                self?.channels = channelsModel.data.channels
            })
            .store(in: &cancellables)
    }
}
