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
    func handleDidTapLoadPersonInfoButton(request: Feature.DidTapLoadPersonInfoButton.Request)
}

struct FeatureView: View {

    let interactor: FeatureInteracting?
    let viewState: ViewState

    var body: some View {
        VStack {
            FeatureNameView(viewState: viewState.nameViewState) {
                interactor?.handleDidTapLoadPersonInfoButton(request: .init())
            }

            FeatureCounterView(interactor: interactor, viewState: viewState.counterViewState)
        }
        .padding()
        .onAppear {
            interactor?.handleOnAppear(request: .init())
        }
    }

    final class ViewState: FeatureDisplaying {

        @Published var nameViewState = FeatureNameView.ViewState()
        @Published var counterViewState = FeatureCounterView.ViewState()

        func displayOnAppear(viewModel: Feature.OnAppear.ViewModel) {
            counterViewState.labelText = viewModel.labelText
        }

        func displayDidTapMinusButton(viewModel: Feature.DidTapMinusButton.ViewModel) {
            counterViewState.labelText = viewModel.labelText
        }

        func displayDidTapPlusButton(viewModel: Feature.DidTapPlusButton.ViewModel) {
            counterViewState.labelText = viewModel.labelText
        }

        func displayDidLoadPersonInfo(viewModel: Feature.DidLoadPersonInfo.ViewModel) {
            nameViewState.nameText = viewModel.nameText
            nameViewState.isRedacted = viewModel.isRedacted
        }

        func displayDidTapLoadPersonInfoButton(viewModel: Feature.DidTapLoadPersonInfoButton.ViewModel) {
            nameViewState.isRedacted = viewModel.isRedacted
        }
    }
}
