//
//  FeatureView.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import SwiftUI

protocol FeatureInteracting {
    func handleOnAppear(request: Feature.OnAppear.Request)
    func handleDidTapMinusButton(request: Feature.DidTapMinusButton.Request)
    func handleDidTapPlusButton(request: Feature.DidTapPlusButton.Request)
}

struct FeatureView: View {

    let interactor: FeatureInteracting?
    let viewState: ViewState

    var body: some View {
        FeatureCounterView(interactor: interactor, viewState: viewState.counterViewState)
            .padding()
            .onAppear {
                interactor?.handleOnAppear(request: .init())
            }
    }

    final class ViewState: FeatureDisplaying {

        let counterViewState = FeatureCounterView.ViewState()

        func displayOnAppear(viewModel: Feature.OnAppear.ViewModel) {
            counterViewState.labelText = viewModel.labelText
        }

        func displayDidTapMinusButton(viewModel: Feature.DidTapMinusButton.ViewModel) {
            counterViewState.labelText = viewModel.labelText
        }

        func displayDidTapPlusButton(viewModel: Feature.DidTapPlusButton.ViewModel) {
            counterViewState.labelText = viewModel.labelText
        }
    }
}
