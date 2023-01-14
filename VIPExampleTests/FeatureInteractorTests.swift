//
//  FeatureInteractorTests.swift
//  FeatureInteractorTests
//
//  Created by Vincent Friedrich on 14.01.23.
//

import XCTest
@testable import VIPExample

final class FeatureInteractorTests: XCTestCase {

    private var mockPersonInfoWorker: MockPersonInfoWorker!
    private var mockPresenter: MockPresenter!
    private var sut: FeatureInteractor!

    override func setUp() {
        super.setUp()

        mockPersonInfoWorker = MockPersonInfoWorker()
        mockPresenter = MockPresenter()
        sut = FeatureInteractor(personInfoWorker: mockPersonInfoWorker, presenter: mockPresenter)
    }

    override func tearDown() {
        mockPresenter = nil
        sut = nil

        super.tearDown()
    }

    func test_handleOnAppear_thenPresentOnAppear() throws {
        // When
        sut.handleOnAppear(request: .init())

        // Then
        XCTAssertTrue(mockPresenter.presentOnAppearInvoked)
    }

    func test_handleOnAppear_thenLoadPersonInfo() {
        // When
        sut.handleOnAppear(request: .init())

        // Then
        XCTAssertTrue(mockPersonInfoWorker.loadInvoked)
    }

    func test_handleOnAppear_givenLoadSucceeds_thenPresentDidLoadPersonInfo() {
        // Given
        let expectedPersonInfo = PersonInfo(
            name: "Test",
            jobTitle: "",
            imageURL: "",
            websites: [],
            description: ""
        )
        mockPersonInfoWorker.stubbedLoadResult = expectedPersonInfo

        let expectation = expectation(description: "Presenter called")
        mockPresenter.presentDidLoadPersonInfoExpectation = expectation

        // When
        sut.handleOnAppear(request: .init())

        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(mockPresenter.presentDidLoadPersonInfoInvoked)
        XCTAssertEqual(mockPresenter.presentDidLoadPersonInfoParameter?.personInfo, expectedPersonInfo)
    }

    func test_handleOnAppear_givenLoadFails_thenPresentDidLoadPersonInfoNotInvoked() {
        // Given
        let expectation = expectation(description: "Presenter called")
        expectation.isInverted = true
        mockPresenter.presentDidLoadPersonInfoExpectation = expectation

        // When
        sut.handleOnAppear(request: .init())

        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertFalse(mockPresenter.presentDidLoadPersonInfoInvoked)
    }

    func test_handleDidTapMinusButton_thenPresentDidTapMinusButton() {
        // When
        sut.handleDidTapMinusButton(request: .init())

        // Then
        XCTAssertTrue(mockPresenter.presentDidTapMinusButtonInvoked)
    }

    func test_handleDidTapMinusButton_repeatedly_thenCounterGetsDecremented() throws {
        // When
        sut.handleDidTapMinusButton(request: .init())
        let firstCounterValue = try XCTUnwrap(mockPresenter.presentDidTapMinusButtonParameter?.counter)

        sut.handleDidTapMinusButton(request: .init())
        let secondCounterValue = try XCTUnwrap(mockPresenter.presentDidTapMinusButtonParameter?.counter)

        // Then
        XCTAssertLessThan(secondCounterValue, firstCounterValue)
    }

    func test_handleDidTapPlusButton_thenPresentDidTapPlusButton() {
        // When
        sut.handleDidTapPlusButton(request: .init())

        // Then
        XCTAssertTrue(mockPresenter.presentDidTapPlusButtonInvoked)
    }

    func test_handleDidTapPlusButton_repeatedly_thenCounterGetsIncremented() throws {
        // When
        sut.handleDidTapPlusButton(request: .init())
        let firstCounterValue = try XCTUnwrap(mockPresenter.presentDidTapPlusButtonParameter?.counter)

        sut.handleDidTapPlusButton(request: .init())
        let secondCounterValue = try XCTUnwrap(mockPresenter.presentDidTapPlusButtonParameter?.counter)

        // Then
        XCTAssertGreaterThan(secondCounterValue, firstCounterValue)
    }

    func test_handleDidTapLoadPersonInfoButton_thenPresentLoadPersonInfoButton() {
        // When
        sut.handleDidTapLoadPersonInfoButton(request: .init())

        // Then
        XCTAssertTrue(mockPresenter.presentDidTapLoadPersonInfoButtonInvoked)
        XCTAssertEqual(mockPresenter.presentDidTapLoadPersonInfoButtonParameter?.isLoading, true)
    }

    func test_handleDidTapLoadPersonInfoButton_thenLoadPersonInfo() {
        // When
        sut.handleDidTapLoadPersonInfoButton(request: .init())

        // Then
        XCTAssertTrue(mockPersonInfoWorker.loadInvoked)
    }

    func test_handleDidTapLoadPersonInfoButton_givenLoadSucceeds_thenPresentDidLoadPersonInfo() {
        // Given
        let expectedPersonInfo = PersonInfo(
            name: "Test",
            jobTitle: "",
            imageURL: "",
            websites: [],
            description: ""
        )
        mockPersonInfoWorker.stubbedLoadResult = expectedPersonInfo

        let expectation = expectation(description: "Presenter called")
        mockPresenter.presentDidLoadPersonInfoExpectation = expectation

        // When
        sut.handleDidTapLoadPersonInfoButton(request: .init())

        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(mockPresenter.presentDidLoadPersonInfoInvoked)
        XCTAssertEqual(mockPresenter.presentDidLoadPersonInfoParameter?.personInfo, expectedPersonInfo)
    }

    func test_handleDidTapLoadPersonInfoButton_givenLoadFails_thenPresentDidLoadPersonInfoNotInvoked() {
        // Given
        let expectation = expectation(description: "Presenter called")
        expectation.isInverted = true
        mockPresenter.presentDidLoadPersonInfoExpectation = expectation

        // When
        sut.handleDidTapLoadPersonInfoButton(request: .init())

        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertFalse(mockPresenter.presentDidLoadPersonInfoInvoked)
    }
}

// MARK: - Mocks

private final class MockPersonInfoWorker: PersonInfoWork {
    var loadInvoked = false
    var stubbedLoadResult: PersonInfo?
    func load(completionHandler: @escaping (PersonInfo) -> Void) {
        loadInvoked = true

        if let stubbedLoadResult {
            completionHandler(stubbedLoadResult)
        }
    }
}

private final class MockPresenter: FeaturePresenting {
    var presentOnAppearInvoked = false
    var presentOnAppearParameter: VIPExample.Feature.OnAppear.Response?
    func presentOnAppear(response: VIPExample.Feature.OnAppear.Response) {
        presentOnAppearInvoked = true
        presentOnAppearParameter = response
    }

    var presentDidTapMinusButtonInvoked = false
    var presentDidTapMinusButtonParameter: VIPExample.Feature.DidTapMinusButton.Response?
    func presentDidTapMinusButton(response: VIPExample.Feature.DidTapMinusButton.Response) {
        presentDidTapMinusButtonInvoked = true
        presentDidTapMinusButtonParameter = response
    }

    var presentDidTapPlusButtonInvoked = false
    var presentDidTapPlusButtonParameter: VIPExample.Feature.DidTapPlusButton.Response?
    func presentDidTapPlusButton(response: VIPExample.Feature.DidTapPlusButton.Response) {
        presentDidTapPlusButtonInvoked = true
        presentDidTapPlusButtonParameter = response
    }


    var presentDidLoadPersonInfoInvoked = false
    var presentDidLoadPersonInfoParameter: VIPExample.Feature.DidLoadPersonInfo.Response?
    var presentDidLoadPersonInfoExpectation: XCTestExpectation?
    func presentDidLoadPersonInfo(response: VIPExample.Feature.DidLoadPersonInfo.Response) {
        defer {
            presentDidLoadPersonInfoExpectation?.fulfill()
        }

        presentDidLoadPersonInfoInvoked = true
        presentDidLoadPersonInfoParameter = response
    }

    var presentDidTapLoadPersonInfoButtonInvoked = false
    var presentDidTapLoadPersonInfoButtonParameter: VIPExample.Feature.DidTapLoadPersonInfoButton.Response?
    func presentDidTapLoadPersonInfoButton(response: VIPExample.Feature.DidTapLoadPersonInfoButton.Response) {
        presentDidTapLoadPersonInfoButtonInvoked = true
        presentDidTapLoadPersonInfoButtonParameter = response
    }
}
