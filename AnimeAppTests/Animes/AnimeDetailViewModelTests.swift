//  AnimeDetailViewModelTests.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 7.10.2024.

import AnilistAPI
@testable import AnimeApp
import Combine
import XCTest

final class AnimeDetailViewModelTests: XCTestCase {
    var viewModel: AnimeDetailViewModel!
    var mockAnimeService: MockAnimeService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockAnimeService = MockAnimeService()
        viewModel = AnimeDetailViewModel(animeID: 1, animeService: mockAnimeService)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAnimeService = nil
        cancellables = nil
        super.tearDown()
    }

    func test_getAnimeDetail_success() {
        // Given

        let mockAnimeDetail = try! MockAnimeData.mockAnimeFull()
        let expectedAnime = mockAnimeDetail
        mockAnimeService.getAnimeDetailResult = .success(expectedAnime)

        // When
        let expectation = XCTestExpectation(description: "Anime detail fetched")
        viewModel.$viewState
            .dropFirst()
            .sink { state in
                if case let .loaded(animeDetail) = state {
                    XCTAssertEqual(animeDetail.id, expectedAnime.id)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        Task {
            await viewModel.getAnimeDetail()
        }

        // Then
        wait(for: [expectation], timeout: 1.5)
    }

    func test_getAnimeDetail_failure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockAnimeService.getAnimeDetailResult = .failure(expectedError)

        // When
        let expectation = XCTestExpectation(description: "Fetch anime error")
        viewModel.$viewState
            .dropFirst()
            .sink { state in
                if case let .error(error) = state {
                    XCTAssertEqual(error as NSError, expectedError)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        Task {
            await viewModel.getAnimeDetail()
        }

        // Then
        wait(for: [expectation], timeout: 1.5)
    }
}
