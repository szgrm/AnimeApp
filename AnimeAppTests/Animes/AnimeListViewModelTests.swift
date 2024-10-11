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

final class AnimeListViewModelTests: XCTestCase {
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
    func test_getAnimes_success() {
        //Given
        let mockAnime = try! MockAnimeData.mockAnimeSmall()

        let expectedAnimes: [AnimeSmall] = [mockAnime]
        mockAnimeService.getAnimesResult = .success(expectedAnimes)

        // When
        let expectation = XCTestExpectation(description: "Animes fetched")
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
        wait(for: [expectation], timeout: 1.5)
    }

    @MainActor
    func test_getAnimes_failure() {
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
        wait(for: [expectation], timeout: 1.5)
    }

    @MainActor
    func test_searchAnime() {
        // Given
        let searchTerm = "Test Anime"

        let mockAnime = try! MockAnimeData.mockAnimeSmall()
        let expectedAnimes: [AnimeSmall] = [mockAnime]
        mockAnimeService.searchAnimesResult = .success(expectedAnimes)

        // When
        let expectation = XCTestExpectation(description: "Search anime")
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
            await viewModel.searchAnime(search: searchTerm)
        }

        // Then
        wait(for: [expectation], timeout: 1.5)
    }
}
