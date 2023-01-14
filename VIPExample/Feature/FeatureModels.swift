//
//  FeatureModels.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import Foundation

enum Feature {
    enum OnAppear {
        struct Request { }

        struct Response {
            let counter: Int
        }

        struct ViewModel {
            let labelText: String
        }
    }

    enum DidTapMinusButton {
        struct Request { }

        struct Response {
            let counter: Int
        }

        struct ViewModel {
            let labelText: String
        }
    }

    enum DidTapPlusButton {
        struct Request { }

        struct Response {
            let counter: Int
        }

        struct ViewModel {
            let labelText: String
        }
    }
}
