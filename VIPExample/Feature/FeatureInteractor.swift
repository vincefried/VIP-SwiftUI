//
//  FeatureInteractor.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import Foundation

protocol FeaturePresenting {
    func presentOnAppear(response: Feature.OnAppear.Response)
    func presentDidTapMinusButton(response: Feature.DidTapMinusButton.Response)
    func presentDidTapPlusButton(response: Feature.DidTapPlusButton.Response)
}

final class FeatureInteractor: FeatureInteracting {

    private var counter: Int = 0
    private let presenter: FeaturePresenting
    init(presenter: FeaturePresenting) {
        self.presenter = presenter
    }

    func handleOnAppear(request: Feature.OnAppear.Request) {
        presenter.presentOnAppear(response: .init(counter: counter))
    }

    func handleDidTapMinusButton(request: Feature.DidTapMinusButton.Request) {
        counter -= 1

        presenter.presentDidTapMinusButton(response: .init(counter: counter))
    }

    func handleDidTapPlusButton(request: Feature.DidTapPlusButton.Request) {
        counter += 1

        presenter.presentDidTapPlusButton(response: .init(counter: counter))
    }
}
