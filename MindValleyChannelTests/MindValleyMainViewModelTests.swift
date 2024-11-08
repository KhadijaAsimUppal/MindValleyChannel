//
//  MindValleyChannelTests.swift
//  MindValleyChannelTests
//
//  Created by Khadija Asim on 02/11/2024.
//

import XCTest
import Combine
@testable import MindValleyChannel

final class MindValleyMainViewModelTests: XCTestCase {
    
    var viewModel: MindValleyMainViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        viewModel = MindValleyMainViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
    }

    func testFetchAllData_PopulatesDataSuccessfully() {
        let expectation = XCTestExpectation(description: "Data is populated successfully")
        
        viewModel.fetchAllData()

        viewModel.$episodes
            .combineLatest(viewModel.$channels, viewModel.$categories)
            .sink { episodes, channels, categories in
                if !episodes.isEmpty && !channels.isEmpty && !categories.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    func testIsLoading_ShowsLoadingIndicator() {
        let expectation = XCTestExpectation(description: "Loading indicator shows correctly")

        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                XCTAssertTrue(isLoading, "isLoading should be true when fetching data")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchAllData()
        
        wait(for: [expectation], timeout: 2.0)
    }
}
