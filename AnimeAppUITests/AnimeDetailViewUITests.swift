//
//  AnimeDetailViewUITests.swift
//  AnimeAppUITests
//
//  Created by Sezgi İrem İlgar on 14.10.2024.
//

import XCTest

final class AnimeDetailViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

        let firstAnimeCell = app.buttons["animeResult"].firstMatch
        XCTAssertTrue(firstAnimeCell.waitForExistence(timeout: 1), "firstAnimeCell should exist")
        firstAnimeCell.tap()

        let animeTitle = app.staticTexts["Attack on Titan"]
        XCTAssertTrue(animeTitle.exists, "Anime title should exist")
    }

    func test_initialLoad() throws {
        let coverImage = app.buttons["coverImage"]
        XCTAssertTrue(coverImage.exists, "Cover image should exist")

        let summaryText = app.staticTexts["SUMMARY"]
        XCTAssertTrue(summaryText.exists, "SUMMARY text should exist on the detail page")

        let chatactersText = app.staticTexts["CHARACTERS"]
        XCTAssertTrue(chatactersText.exists, "CHARACTERS text should exist on the detail page")
    }

    func test_coverImageFullScreen() throws {
        let coverImage = app.buttons["coverImage"]
        XCTAssertTrue(coverImage.exists, "Cover image should exist")
        coverImage.tap()

        let coverImageFullScreen = app.images["fullCoverImage"]
        XCTAssertTrue(coverImageFullScreen.waitForExistence(timeout: 1), "Full cover image should be fullscreen")

        app.swipeDown(velocity: .fast)

        XCTAssertFalse(coverImageFullScreen.exists, "Full cover image should not exist")
    }

    func test_showMoreToggle() throws {
        let showMoreButton = app.buttons["showMoreToggle"]
        XCTAssertTrue(showMoreButton.exists, "Show more button should exist")
        XCTAssertTrue(showMoreButton.label == "Show More", "Button label should be 'Show More'")

        let initialSummaryFrame = app.staticTexts["summaryText"].frame

        showMoreButton.tap()

        app.scrollViews.firstMatch.swipeUp(velocity: .slow)

        let showLessButton = app.buttons["showMoreToggle"]
        XCTAssertTrue(showLessButton.exists, "Show less button should exist")
        XCTAssertTrue(showLessButton.label == "Show Less", "Button label should be 'Show Less'")

        let expandedSummaryFrame = app.staticTexts["summaryText"].frame
        XCTAssertNotEqual(initialSummaryFrame, expandedSummaryFrame, "More content should be visible after tapping Show More")

        showLessButton.tap()

        app.scrollViews.firstMatch.swipeDown(velocity: .slow)

        let collapsedSummaryFrame = app.staticTexts["summaryText"].frame
        XCTAssertEqual(initialSummaryFrame, collapsedSummaryFrame, "Content should return to initial state after tapping Show Less")
    }

    func test_characterDetailNavigation() throws {
        let firstCharacterCell = app.buttons["characterCell"].firstMatch
        XCTAssertTrue(firstCharacterCell.exists, "firstCharacterCell should exist")

        firstCharacterCell.tap()

        let characterTitle = app.staticTexts["Levi"]
        XCTAssertTrue(characterTitle.waitForExistence(timeout: 1), "Character title should be exist on the detail page")

        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.exists, "backButton should exist")
        backButton.tap()

        let animeTitle = app.staticTexts["Attack on Titan"]
        XCTAssertTrue(animeTitle.exists, "Anime title should exist")
    }
}
