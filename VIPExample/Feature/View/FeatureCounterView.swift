//
//  FeatureCounterView.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import SwiftUI

struct FeatureCounterView: View {
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
    }

    final class ViewState: ObservableObject {
        @Published var labelText: String = ""
    }
}

struct FeatureCounterView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCounterView(interactor: nil, viewState: .example)
    }
}

extension FeatureCounterView.ViewState {
    static let example: FeatureCounterView.ViewState = {
        let viewState = FeatureCounterView.ViewState()
        viewState.labelText = "3"
        return viewState
    }()
}
