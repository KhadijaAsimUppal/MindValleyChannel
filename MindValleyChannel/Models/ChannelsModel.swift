//
//  ChannelModel.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

struct ChannelsModel: Codable {
    let data: ChannelsDataModel
}

struct ChannelsDataModel: Codable {
    let channels: [ChannelModel]
}

struct ChannelModel: Codable {
    let id: String
    let title: String
    let mediaCount: Int
    let series: [SeriesModel]?
    let latestMedia: [CourseModel]
    let iconAsset: ThumbnailAssetModel?
    let coverAsset: CoverAssetModel
}

struct ThumbnailAssetModel: Codable {
    let thumbnailUrl: String
}
