//
//  VIPExampleApp.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import SwiftUI

@main
struct VIPExampleApp: App {
    var body: some Scene {
        WindowGroup {
            Self.buildFeatureScene()
        }
    }

    private static func buildFeatureScene() -> FeatureView {
        let viewState = FeatureView.ViewState()
        let presenter = FeaturePresenter()
        let interactor = FeatureInteractor(presenter: presenter)
        let view = FeatureView(interactor: interactor, viewState: viewState)

        presenter.display = viewState

        return view
    }
}
