//
//  FeatureInteractorTests.swift
//  FeatureInteractorTests
//
//  Created by Vincent Friedrich on 14.01.23.
//

import XCTest
@testable import VIPExample

final class FeatureInteractorTests: XCTestCase {

    private var mockPresenter: MockPresenter!
    private var sut: FeatureInteractor!

    override func setUp() {
        super.setUp()

        mockPresenter = MockPresenter()
        sut = FeatureInteractor(presenter: mockPresenter)
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
}

// MARK: - Mocks

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
}
