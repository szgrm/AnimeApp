//
//  AnimeListViewModelTests.swift
//  AnimeAppTests
//
//  Created by Sezgi İrem İlgar on 20.09.2024.
//

import AnilistAPI
@testable import AnimeApp
import Combine
import XCTest

class AnimeListViewModelTests: XCTestCase {
    var viewModel: AnimeListViewModel!
    var mockAnimeService: MockAnimeService!
    var cancellables: Set<AnyCancellable>!

    @MainActor
    override func setUp() {
        super.setUp()
        mockAnimeService = MockAnimeService()
        viewModel = AnimeListViewModel(animeService: mockAnimeService)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAnimeService = nil
        cancellables = nil
        super.tearDown()
    }

    @MainActor
    func testGetAnimes_Success() {
        // Given
        let expectedAnimes: [AnimeSmall] = []
        mockAnimeService.getAnimesResult = .success(expectedAnimes)

        // When
        let expectation = XCTestExpectation(description: "Fetch animes")
        viewModel.$viewState
            .dropFirst()
            .sink { state in
                if case let .loaded(animes) = state {
                    XCTAssertEqual(animes.count, expectedAnimes.count)
                    XCTAssertEqual(animes.first?.id, expectedAnimes.first?.id)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        Task {
            await viewModel.getAnimes()
        }

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    @MainActor
    func testGetAnimes_Failure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockAnimeService.getAnimesResult = .failure(expectedError)

        // When
        let expectation = XCTestExpectation(description: "Fetch animes error")
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
            await viewModel.getAnimes()
        }

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    @MainActor
    func testSearchAnime() {
        // Given
        let searchTerm = "Test Anime"
        let expectedAnimes: [AnimeSmall] = []
        mockAnimeService.searchAnimesResult = .success(expectedAnimes)
        mockAnimeService.getAnimesResult = .success(expectedAnimes)

        // When
        let expectation = XCTestExpectation(description: "Search anime")
        viewModel.$viewState
            .dropFirst()
            .sink { state in
                print("state: \(state)")
                if case let .loaded(animes) = state {
                    print("animes: \(animes)")
                    XCTAssertEqual(animes.count, expectedAnimes.count)
                    XCTAssertEqual(animes.first?.id, expectedAnimes.first?.id)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.searchTerm = searchTerm

        // Then
        wait(for: [expectation], timeout: 1.5)
    }
}
