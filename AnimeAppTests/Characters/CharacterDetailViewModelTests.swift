//
//  CharacterDetailViewModelTests.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 11.10.2024.
//

import AnilistAPI
@testable import AnimeApp
import Combine
import XCTest

final class CharacterDetailViewModelTests: XCTestCase {
    var viewModel: CharacterDetailViewModel!
    var mockCharacterService: MockCharacterService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockCharacterService = MockCharacterService()
        viewModel = CharacterDetailViewModel(characterID: 1, characterService: mockCharacterService)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockCharacterService = nil
        cancellables = nil
        super.tearDown()
    }

    func test_getCharacterDetail_success() {
        // Given
        let mockCharacterDetail = try! MockCharacterData.mockCharacterFull()
        let expectedCharacter = mockCharacterDetail
        mockCharacterService.getCharacterDetailResult = .success(expectedCharacter)

        // When
        let expectation = XCTestExpectation(description: "Character detail fetched")
        viewModel.$viewState
            .dropFirst()
            .sink { state in
                if case let .loaded(characterDetail) = state {
                    XCTAssertEqual(characterDetail.id, expectedCharacter.id)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        Task {
            await viewModel.getCharacterDetail()
        }

        // Then
        wait(for: [expectation], timeout: 1.5)
    }

    func test_getAnimeDetail_failure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockCharacterService.getCharacterDetailResult = .failure(expectedError)

        // When
        let expectation = XCTestExpectation(description: "Fetch character error")
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
            await viewModel.getCharacterDetail()
        }

        // Then
        wait(for: [expectation], timeout: 1.5)
    }
}
