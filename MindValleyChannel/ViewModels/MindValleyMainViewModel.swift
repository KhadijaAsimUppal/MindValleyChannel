//
//  EpisodesViewModel.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import UIKit
import Combine

///ViewModel responsible for fetching and managing data for the MindValley main view, including episodes, channels, and categories.
class MindValleyMainViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var episodes: [EpisodeModel] = []
    @Published private(set) var channels: [ChannelModel] = []
    @Published private(set) var categories: [CategoryModel] = []
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
    
    func resetData() {
        episodes = []
        channels = []
        categories = []
    }
}

// MARK: - TableView Configuration
extension MindValleyMainViewModel {
    
    /// Returns the number of sections in the table view.
    var numberOfSections: Int {
        return ContentSection.allCases.count
    }
    
    /// Returns the number of rows in a section.
    func numberOfRows(in section: Int) -> Int {
        guard let contentSection = ContentSection(rawValue: section) else { return 0 }
        switch contentSection {
        case .episodes, .categories:
            return 1
        case .channels:
            return channels.count
        }
    }
    
    /// Returns the height for a section header.
    func heightForHeader(in section: Int) -> CGFloat {
        guard let contentSection = ContentSection(rawValue: section) else { return 0 }
        return contentSection == .channels ? 0 : 40
    }
    
    /// Returns the height for a specific section.
    func heightForSection(at section: Int) -> CGFloat {
        guard let contentSection = ContentSection(rawValue: section) else { return UITableView.automaticDimension }
        switch contentSection {
        case .episodes:
            return 372
        case .channels:
            return 380
        case .categories:
            return 400
        }
    }
}

// MARK: - Data Access Methods
extension MindValleyMainViewModel {
    
    func getEpisodes() -> [EpisodeModel] {
        return episodes
    }
    
    func getChannel(at index: Int) -> ChannelModel? {
        guard index >= 0 && index < channels.count else { return nil }
        return channels[index]
    }
    
    func getCategories() -> [CategoryModel] {
        return categories
    }
}

// MARK: - Data Fetch Methods
extension MindValleyMainViewModel {
    
    /// Fetches episodes data from the episode service.
    /// Updates `episodes` on success, or sets `episodesErrorMessage` on failure.
    func fetchEpisodes() {
        episodeService.fetchEpisodes()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] episodes in
                self?.episodes = episodes
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
