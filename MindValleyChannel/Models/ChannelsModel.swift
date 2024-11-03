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
    let title: String
    let series: [SeriesModel]?
    let mediaCount: Int
    let latestMedia: [CourseModel]
    let id: String?
    let iconAsset: ThumbnailAssetModel?
    let coverAsset: CoverAssetModel
}

struct ThumbnailAssetModel: Codable {
    let thumbnailUrl: String?
}
