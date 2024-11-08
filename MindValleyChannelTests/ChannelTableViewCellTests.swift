//
//  MindValleyChannelTests.swift
//  MindValleyChannelTests
//
//  Created by Khadija Asim on 02/11/2024.
//

import XCTest
@testable import MindValleyChannel

final class ChannelTableViewCellTests: XCTestCase {
    var cell: ChannelTableViewCell!

    override func setUpWithError() throws {
        let nib = UINib(nibName: "ChannelTableViewCell", bundle: nil)
        cell = nib.instantiate(withOwner: nil, options: nil).first as? ChannelTableViewCell
    }

    override func tearDownWithError() throws {
        cell = nil
    }
    
    func testConfigureWithChannel_UpdatesUICorrectly() {
        let channel = ChannelModel(title: "Test Channel",
                                   series: nil,
                                   mediaCount: 10, latestMedia: [],
                                   id: "1",
                                   iconAsset: nil,
                                   coverAsset: CoverAssetModel(url:"https://example.com/icon.jpg"))
        
        cell.configure(with: channel)
        
        XCTAssertEqual(cell.titleLabel.text, "Test Channel", "The channel title should be displayed correctly.")
        XCTAssertEqual(cell.episodeCountLabel.text, "10 episodes", "The episode count should be displayed correctly.")
    }
}
