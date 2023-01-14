//
//  FeatureNameView.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import SwiftUI

struct FeatureNameView: View {
    @ObservedObject var viewState: ViewState
    let reloadButtonAction: () -> Void

    var body: some View {
        HStack {
            Text(viewState.nameText)
                .font(.largeTitle)

            Button {
                reloadButtonAction()
            } label: {
                Image(systemName: "arrow.counterclockwise")
            }
        }
        .redacted(reason: viewState.isRedacted ? .placeholder : [])
        .animation(.default, value: viewState.isRedacted)
    }

    final class ViewState: ObservableObject {
        @Published var nameText: String = "Dummy Name"
        @Published var isRedacted: Bool = true
    }
}

struct FeatureNameView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureNameView(viewState: .init()) {}
    }
}
