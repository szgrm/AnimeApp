//
//  AnimeListViewUITests.swift
//  AnimeAppUITests
//
//  Created by Sezgi İrem İlgar on 13.10.2024.
//

import XCTest

final class AnimeListViewUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {}

    func test_initialLoad() throws {
        XCTAssertTrue(app.navigationBars["Animes"].exists, "Animes navigation bar should exist")

        let searchField = app.searchFields["Search Anime"]
        XCTAssertTrue(searchField.exists, "Search field should exist")

        let animeList = app.buttons["animeResult"]
        XCTAssertTrue(animeList.waitForExistence(timeout: 1), "animeList should exist")
    }

    func test_animeSearch() throws {
        let searchField = app.searchFields["Search Anime"]
        XCTAssertTrue(searchField.exists, "Search field should exist")
        searchField.tap()
        searchField.typeText("jujutsu kaisen")

        let firstResult = app.buttons["animeResult"].firstMatch
        XCTAssertTrue(firstResult.waitForExistence(timeout: 2), "Search results should exist")

        let resultText = firstResult.label.lowercased()
        XCTAssertTrue(resultText.contains("jujutsu kaisen"), "Search results should contain 'jujutsu kaisen'")
    }

    func test_animeDetailNavigation() throws {
        let firstAnimeCell = app.buttons["animeResult"].firstMatch
        XCTAssertTrue(firstAnimeCell.waitForExistence(timeout: 1), "firstAnimeCell should exist")
        firstAnimeCell.tap()

        let summaryText = app.staticTexts["SUMMARY"]
        XCTAssertTrue(summaryText.waitForExistence(timeout: 1), "SUMMARY text should be exist on the detail page")

        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.exists, "backButton should exist")
        backButton.tap()

        let animeListNavBar = app.navigationBars["Animes"]
        XCTAssertTrue(animeListNavBar.exists, "Should return to the Animes list")
    }

    func test_scrollToTop() throws {
        let scrollView = app.scrollViews
        scrollView.element.swipeUp(velocity: .fast)

        let upButton = app.buttons["arrow.up.circle.fill"]
        XCTAssertTrue(upButton.waitForExistence(timeout: 2), "upButton should exist")
        upButton.tap()

        let topAnimeCell = app.buttons["animeResult"].firstMatch
        XCTAssertTrue(topAnimeCell.waitForExistence(timeout: 1), "The app should scroll back to the top, showing the first anime result")
    }
}
