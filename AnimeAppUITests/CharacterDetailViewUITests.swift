//
//  CharacterDetailViewUITests.swift
//  AnimeAppUITests
//
//  Created by Sezgi İrem İlgar on 14.10.2024.
//

import XCTest

final class CharacterDetailViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

        let characterTabBar = app.tabBars.buttons["Characters"]
        XCTAssertTrue(characterTabBar.exists, "Characters tab bar should exist")
        characterTabBar.tap()
        XCTAssertTrue(app.navigationBars["Characters"].exists, "Characters navigation bar should exist")

        let firstCharacterCell = app.buttons["characterResult"].firstMatch
        XCTAssertTrue(firstCharacterCell.waitForExistence(timeout: 1), "firstAnimeCell should exist")
        firstCharacterCell.tap()

        let characterTitle = app.staticTexts["Satoru Gojou"]
        XCTAssertTrue(characterTitle.exists, "Character title should exist")
    }

    func test_initialLoad() throws {
        let characterImage = app.images.firstMatch
        XCTAssertTrue(characterImage.exists, "Character image should exist")

        let descriptionText = app.staticTexts["DESCRIPTION"]
        XCTAssertTrue(descriptionText.waitForExistence(timeout: 1), "DESCRIPTION text should be exist on the detail page")

        let mediaText = app.staticTexts["MEDIA"]
        XCTAssertTrue(mediaText.exists, "MEDIA text should exist on the detail page")
    }

    func test_showMoreToggle() throws {
        let showMoreButton = app.buttons["showMoreToggle"]
        XCTAssertTrue(showMoreButton.exists, "Show more button should exist")
        XCTAssertTrue(showMoreButton.label == "Show More", "Button label should be 'Show More'")

        let initialDescriptionFrame = app.staticTexts["descriptionText"].frame

        showMoreButton.tap()

        app.scrollViews.firstMatch.swipeUp(velocity: .slow)

        let showLessButton = app.buttons["showMoreToggle"]
        XCTAssertTrue(showLessButton.exists, "Show less button should exist")
        XCTAssertTrue(showLessButton.label == "Show Less", "Button label should be 'Show Less'")

        let expandedDescriptionFrame = app.staticTexts["descriptionText"].frame
        XCTAssertNotEqual(initialDescriptionFrame, expandedDescriptionFrame, "More content should be visible after tapping Show More")

        showLessButton.tap()

        app.scrollViews.firstMatch.swipeDown(velocity: .slow)

        let collapsedDescriptionFrame = app.staticTexts["descriptionText"].frame
        XCTAssertEqual(initialDescriptionFrame, collapsedDescriptionFrame, "Content should return to initial state after tapping Show Less")
    }

    func test_animeDetailNavigation() throws {
        let firsAnimeCell = app.buttons["animeCell"].firstMatch
        XCTAssertTrue(firsAnimeCell.exists, "firsAnimeCell should exist")

        firsAnimeCell.tap()

        let animeTitle = app.staticTexts["JUJUTSU KAISEN"]
        XCTAssertTrue(animeTitle.waitForExistence(timeout: 1), "Anime title should be exist on the detail page")

        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.exists, "backButton should exist")
        backButton.tap()

        let characterTitle = app.staticTexts["Satoru Gojou"]
        XCTAssertTrue(characterTitle.exists, "Character title should exist")
    }
}
