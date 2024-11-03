//
//  EpisodesViewModel.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation
import Combine

/// ViewModel responsible for fetching and managing data for the MindValley main view, including episodes, channels, and categories.
class MindValleyMainViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var episodes: [EpisodeModel] = []
    @Published var channels: [ChannelModel] = []
    @Published var categories: [CategoryModel] = []
    
    @Published var episodesErrorMessage: String?
    @Published var channelsErrorMessage: String?
    @Published var categoriesErrorMessage: String?
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    private let episodeService: EpisodeService
    private let channelsService: ChannelsService
    private let categoriesService: CategoriesService
    
    // MARK: - Initializer
    init() {
        let networkService = NetworkService()
        self.episodeService = EpisodeService(networkService: networkService)
        self.channelsService = ChannelsService(networkService: networkService)
        self.categoriesService = CategoriesService(networkService: networkService)
    }
}

// MARK: - Fetch Methods
extension MindValleyMainViewModel {
    /// Fetches episodes data from the episode service.
    /// Updates `episodes` on success, or sets `episodesErrorMessage` on failure.
    func fetchEpisodes() {
        episodeService.fetchEpisodes()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.episodesErrorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] episodesModel in
                self?.episodes = episodesModel.data.media
            })
            .store(in: &cancellables)
    }
    
    /// Fetches channels data from the channels service.
    /// Updates `channels` on success, or sets `channelsErrorMessage` on failure.
    func fetchChannels() {
        channelsService.fetchChannels()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.channelsErrorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] channelsModel in
                self?.channels = channelsModel.data.channels
            })
            .store(in: &cancellables)
    }
    
    /// Fetches categories data from the categories service.
    /// Updates `categories` on success, or sets `categoriesErrorMessage` on failure.
    func fetchCategories() {
        categoriesService.fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.categoriesErrorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] categoriesModel in
                self?.categories = categoriesModel.data.categories
            })
            .store(in: &cancellables)
    }
}
