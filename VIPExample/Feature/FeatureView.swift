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
    @ObservedObject var viewState: ViewState

    var body: some View {
        HStack(spacing: 20) {
            Button {
                interactor?.handleDidTapMinusButton(request: .init())
            } label: {
                Image(systemName: "minus.circle.fill")
            }

            Text(viewState.labelText)

            Button {
                interactor?.handleDidTapPlusButton(request: .init())
            } label: {
                Image(systemName: "plus.circle.fill")
            }
        }
        .font(.largeTitle)
        .fontDesign(.rounded)
        .padding()
        .onAppear {
            interactor?.handleOnAppear(request: .init())
        }
    }

    final class ViewState: ObservableObject, FeatureDisplaying {

        @Published var labelText: String = ""

        func displayOnAppear(viewModel: Feature.OnAppear.ViewModel) {
            labelText = viewModel.labelText
        }

        func displayDidTapMinusButton(viewModel: Feature.DidTapMinusButton.ViewModel) {
            labelText = viewModel.labelText
        }

        func displayDidTapPlusButton(viewModel: Feature.DidTapPlusButton.ViewModel) {
            labelText = viewModel.labelText
        }
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(interactor: nil, viewState: .example)
    }
}

extension FeatureView.ViewState {
    static let example: FeatureView.ViewState = {
        let viewState = FeatureView.ViewState()
        viewState.labelText = "3"
        return viewState
    }()
}
