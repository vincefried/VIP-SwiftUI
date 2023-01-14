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

    enum DidTapLoadPersonInfoButton {
        struct Request { }

        struct Response {
            let isLoading: Bool
        }

        struct ViewModel {
            let isRedacted: Bool
        }
    }

    enum DidLoadPersonInfo {
        struct Response {
            let personInfo: PersonInfo
        }

        struct ViewModel {
            let nameText: String
            let isRedacted: Bool
        }
    }
}
