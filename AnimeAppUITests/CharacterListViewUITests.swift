//
//  CharacterListViewUITests.swift
//  AnimeAppUITests
//
//  Created by Sezgi İrem İlgar on 14.10.2024.
//

import XCTest

final class CharacterListViewUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

        let characterTabBar = app.tabBars.buttons["Characters"]
        XCTAssertTrue(characterTabBar.exists, "Characters tab bar should exist")
        characterTabBar.tap()
        XCTAssertTrue(app.navigationBars["Characters"].exists, "Characters navigation bar should exist")
    }

    override func tearDownWithError() throws {}

    func test_initialLoad() throws {
        let searchField = app.searchFields["Search Character"]
        XCTAssertTrue(searchField.exists, "Search field should exist")

        let characterList = app.buttons["characterResult"]
        XCTAssertTrue(characterList.waitForExistence(timeout: 1), "characterResult should exist")
    }

    func test_characterSearch() throws {
        let searchField = app.searchFields["Search Character"]
        XCTAssertTrue(searchField.exists, "Search field should exist")
        searchField.tap()
        searchField.typeText("spike spiegel")

        let firstResult = app.buttons["characterResult"].firstMatch
        XCTAssertTrue(firstResult.waitForExistence(timeout: 2), "Search results should exist")

        let resultText = firstResult.label.lowercased()
        XCTAssertTrue(resultText.contains("spike spiegel"), "Search results should contain 'Spike spiegel'")
    }

    func test_characterDetailNavigation() throws {
        let firstCharacterCell = app.buttons["characterResult"].firstMatch
        XCTAssertTrue(firstCharacterCell.waitForExistence(timeout: 1), "firstCharacterCell should exist")
        firstCharacterCell.tap()

        let descriptionText = app.staticTexts["DESCRIPTION"]
        XCTAssertTrue(descriptionText.waitForExistence(timeout: 1), "DESCRIPTION text should be exist on the detail page")

        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.exists, "backButton should exist")
        backButton.tap()

        let characterListNavBar = app.navigationBars["Characters"]
        XCTAssertTrue(characterListNavBar.exists, "Should return to the Character list")
    }

    func test_scrollToTop() throws {
        let scrollView = app.scrollViews
        scrollView.element.swipeUp(velocity: .fast)

        let upButton = app.buttons["arrow.up.circle.fill"]
        XCTAssertTrue(upButton.waitForExistence(timeout: 2), "upButton should exist")
        upButton.tap()

        let topCharacterCell = app.buttons["characterResult"].firstMatch
        XCTAssertTrue(topCharacterCell.waitForExistence(timeout: 1), "The app should scroll back to the top, showing the first anime result")
    }
}
