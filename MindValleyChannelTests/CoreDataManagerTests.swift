//
//  MindValleyChannelTests.swift
//  MindValleyChannelTests
//
//  Created by Khadija Asim on 02/11/2024.
//

import XCTest
@testable import MindValleyChannel

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManager.shared

    }

    override func tearDownWithError() throws {
        coreDataManager = nil
    }

    func testSaveAndFetchEpisode() {
        let episode = EpisodeModel(type: "audio", title: "Sample Episode", coverAsset: CoverAssetModel(url: "https://example.com/image.jpg"), channel: ChannelInfoModel(title: "Sample Channel"))
        
        coreDataManager.saveEpisode(episode)
        
        let fetchedEpisodes = coreDataManager.fetchEpisodes()
        
        XCTAssertTrue(fetchedEpisodes.contains { $0.title == "Sample Episode" }, "The saved episode should be fetched correctly.")
    }

    func testSaveAndFetchCategory() {
        let category = CategoryModel(name: "Sample Category")
        
        coreDataManager.saveCategory(category)
        
        let fetchedCategories = coreDataManager.fetchCategories()
        
        XCTAssertTrue(fetchedCategories.contains { $0.name == "Sample Category" }, "The saved category should be fetched correctly.")
    }
}
