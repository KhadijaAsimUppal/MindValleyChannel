//
//  ChannelsService.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 03/11/2024.
//

import Combine

class ChannelsService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchChannels() -> AnyPublisher<ChannelsModel, NetworkError> {
        return networkService.request(MindValleyAPI.getChannels, decodingType: ChannelsModel.self)
    }
}
