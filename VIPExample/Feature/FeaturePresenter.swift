//
//  FeaturePresenter.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import Foundation

protocol FeatureDisplaying: AnyObject {
    func displayOnAppear(viewModel: Feature.OnAppear.ViewModel)
    func displayDidTapMinusButton(viewModel: Feature.DidTapMinusButton.ViewModel)
    func displayDidTapPlusButton(viewModel: Feature.DidTapPlusButton.ViewModel)
}

final class FeaturePresenter: FeaturePresenting {

    weak var display: FeatureDisplaying?

    func presentOnAppear(response: Feature.OnAppear.Response) {
        display?.displayOnAppear(viewModel: .init(labelText: String(response.counter)))
    }

    func presentDidTapMinusButton(response: Feature.DidTapMinusButton.Response) {
        display?.displayDidTapMinusButton(viewModel: .init(labelText: String(response.counter)))
    }

    func presentDidTapPlusButton(response: Feature.DidTapPlusButton.Response) {
        display?.displayDidTapPlusButton(viewModel: .init(labelText: String(response.counter)))
    }
}
