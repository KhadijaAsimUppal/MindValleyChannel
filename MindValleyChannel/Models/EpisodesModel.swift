//
//  EpisodeModel.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation

struct EpisodesModel: Codable {
    let data: EpisodesDataModel
}

struct EpisodesDataModel: Codable {
    let media: [EpisodeModel]
}

struct EpisodeModel: Codable {
    let type: String
    let title: String
    let coverAsset: CoverAssetModel
    let channel: ChannelInfoModel
}

struct CoverAssetModel: Codable {
    let url: String
}

struct ChannelInfoModel: Codable {
    let title: String
}
