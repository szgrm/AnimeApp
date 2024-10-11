//
//  CharacterListViewModelTests.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 8.10.2024.
//

import AnilistAPI
@testable import AnimeApp
import Combine
import XCTest

final class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharacterListViewModel!
    var mockCharacterService: MockCharacterService!
    var cancellables: Set<AnyCancellable>!

    @MainActor
    override func setUp() {
        super.setUp()
        mockCharacterService = MockCharacterService()
        viewModel = CharacterListViewModel(characterService: mockCharacterService)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockCharacterService = nil
        cancellables = nil
        super.tearDown()
    }

    @MainActor
    func test_getCharacters_success() {
        // Given
        let data: [String: Any] = [
            "__typename": "Character",
            "id": 127_691,
            "name": [
                "__typename": "CharacterName",
                "full": "Satoru Gojou"
            ],
            "image": [
                "__typename": "CharacterImage",
                "large": "https://s4.anilist.co/file/anilistcdn/character/large/b127691-UmAY8k2uXeQM.png"
            ]
        ]

        let mockCharacter = try! CharacterSmall(data: data)
        let expectedCharacters: [CharacterSmall] = [mockCharacter]

        mockCharacterService.getCharactersResult = .success(expectedCharacters)

        // When
        let expectation = XCTestExpectation(description: "Characters fetched")
        viewModel.$viewState
            .dropFirst()
            .sink { state in
                if case let .loaded(characters) = state {
                    XCTAssertEqual(characters.count, expectedCharacters.count)
                    XCTAssertEqual(characters.first?.id, expectedCharacters.first?.id)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        Task {
            await viewModel.getCharacters()
        }

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    @MainActor
    func test_getCharacters_failure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockCharacterService.getCharactersResult = .failure(expectedError)

        // When
        let expectation = XCTestExpectation(description: "Fetch charater error")
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
            await viewModel.getCharacters()
        }

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    @MainActor func test_searchCharacter() {
        // Given
        let searchTerm = "Test Character"
        let data: [String: Any] = [
            "__typename": "Character",
            "id": 127_691,
            "name": [
                "__typename": "CharacterName",
                "full": "Satoru Gojou"
            ],
            "image": [
                "__typename": "CharacterImage",
                "large": "https://s4.anilist.co/file/anilistcdn/character/large/b127691-UmAY8k2uXeQM.png"
            ]
        ]
        let mockCharacter = try! CharacterSmall(data: data)
        let expectedCharacters: [CharacterSmall] = [mockCharacter]
        mockCharacterService.searchCharactersResult = .success(expectedCharacters)

        // When
        let expectation = XCTestExpectation(description: "Search character")
        viewModel.$viewState
            .dropFirst()
            .sink { state in
                if case let .loaded(character) = state {
                    XCTAssertEqual(character.count, expectedCharacters.count)
                    XCTAssertEqual(character.first?.id, expectedCharacters.first?.id)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        Task {
            await viewModel.searchCharacter(search: searchTerm)
        }

        // Then
        wait(for: [expectation], timeout: 1.5)
    }
}
