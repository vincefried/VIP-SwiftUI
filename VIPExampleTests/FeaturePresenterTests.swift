//
//  FeaturePresenterTests.swift
//  VIPExampleTests
//
//  Created by Vincent Friedrich on 14.01.23.
//

import XCTest
@testable import VIPExample

final class FeaturePresenterTests: XCTestCase {

    private var mockDisplay: MockDisplay!
    private var sut: FeaturePresenter!

    override func setUp() {
        super.setUp()

        mockDisplay = MockDisplay()
        sut = FeaturePresenter()
        sut.display = mockDisplay
    }

    override func tearDown() {
        mockDisplay = nil
        sut = nil

        super.tearDown()
    }

    func test_presentOnAppear_thenDisplayOnAppear() throws {
        // When
        sut.presentOnAppear(response: .init(counter: 3))

        // Then
        XCTAssertTrue(mockDisplay.displayOnAppearInvoked)
        XCTAssertEqual(mockDisplay.displayOnAppearParameter?.labelText, "3")
    }

    func test_presentDidTapMinusButton_thenDisplayDidTapMinusButton() throws {
        // When
        sut.presentDidTapMinusButton(response: .init(counter: 3))

        // Then
        XCTAssertTrue(mockDisplay.displayDidTapMinusButtonInvoked)
        XCTAssertEqual(mockDisplay.displayDidTapMinusButtonParameter?.labelText, "3")
    }

    func test_presentDidTapPlusButton_thenDisplayDidTapPlusButton() throws {
        // When
        sut.presentDidTapPlusButton(response: .init(counter: 3))

        // Then
        XCTAssertTrue(mockDisplay.displayDidTapPlusButtonInvoked)
        XCTAssertEqual(mockDisplay.displayDidTapPlusButtonParameter?.labelText, "3")
    }

    func test_presentDidLoadPersonInfo_thenDisplayDidLoadPersonInfo() {
        // Given
        let personInfo = PersonInfo(
            name: "Test",
            jobTitle: "",
            imageURL: "",
            websites: [],
            description: ""
        )

        // When
        sut.presentDidLoadPersonInfo(response: .init(personInfo: personInfo))

        // Then
        XCTAssertTrue(mockDisplay.displayDidLoadPersonInfoInvoked)
        XCTAssertEqual(mockDisplay.displayDidLoadPersonInfoParameter?.isRedacted, false)
        XCTAssertEqual(mockDisplay.displayDidLoadPersonInfoParameter?.nameText, "Test")
    }

    func test_presentDidTapLoadPersonInfoButton_givenIsLoading_thenDisplayDidTapLoadPersonInfoButtonRedacted() {
        // Given
        let isLoading = true

        // When
        sut.presentDidTapLoadPersonInfoButton(response: .init(isLoading: isLoading))

        // Then
        XCTAssertTrue(mockDisplay.displayDidTapLoadPersonInfoButton)
        XCTAssertEqual(mockDisplay.displayDidTapLoadPersonInfoButtonParameter?.isRedacted, true)
    }

    func test_presentDidTapLoadPersonInfoButton_givenIsNotLoading_thenDisplayDidTapLoadPersonInfoButtonNotRedacted() {
        // Given
        let isLoading = false

        // When
        sut.presentDidTapLoadPersonInfoButton(response: .init(isLoading: isLoading))

        // Then
        XCTAssertTrue(mockDisplay.displayDidTapLoadPersonInfoButton)
        XCTAssertEqual(mockDisplay.displayDidTapLoadPersonInfoButtonParameter?.isRedacted, false)
    }
}

// MARK: - Mocks

private final class MockDisplay: FeatureDisplaying {
    var displayOnAppearInvoked = false
    var displayOnAppearParameter: VIPExample.Feature.OnAppear.ViewModel?
    func displayOnAppear(viewModel: VIPExample.Feature.OnAppear.ViewModel) {
        displayOnAppearInvoked = true
        displayOnAppearParameter = viewModel
    }

    var displayDidTapMinusButtonInvoked = false
    var displayDidTapMinusButtonParameter: VIPExample.Feature.DidTapMinusButton.ViewModel?
    func displayDidTapMinusButton(viewModel: VIPExample.Feature.DidTapMinusButton.ViewModel) {
        displayDidTapMinusButtonInvoked = true
        displayDidTapMinusButtonParameter = viewModel
    }

    var displayDidTapPlusButtonInvoked = false
    var displayDidTapPlusButtonParameter: VIPExample.Feature.DidTapPlusButton.ViewModel?
    func displayDidTapPlusButton(viewModel: VIPExample.Feature.DidTapPlusButton.ViewModel) {
        displayDidTapPlusButtonInvoked = true
        displayDidTapPlusButtonParameter = viewModel
    }

    var displayDidLoadPersonInfoInvoked = false
    var displayDidLoadPersonInfoParameter: VIPExample.Feature.DidLoadPersonInfo.ViewModel?
    func displayDidLoadPersonInfo(viewModel: VIPExample.Feature.DidLoadPersonInfo.ViewModel) {
        displayDidLoadPersonInfoInvoked = true
        displayDidLoadPersonInfoParameter = viewModel
    }

    var displayDidTapLoadPersonInfoButton = false
    var displayDidTapLoadPersonInfoButtonParameter: VIPExample.Feature.DidTapLoadPersonInfoButton.ViewModel?
    func displayDidTapLoadPersonInfoButton(viewModel: VIPExample.Feature.DidTapLoadPersonInfoButton.ViewModel) {
        displayDidTapLoadPersonInfoButton = true
        displayDidTapLoadPersonInfoButtonParameter = viewModel
    }
}
