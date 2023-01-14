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
    func presentDidLoadPersonInfo(response: Feature.DidLoadPersonInfo.Response)
    func presentDidTapLoadPersonInfoButton(response: Feature.DidTapLoadPersonInfoButton.Response)
}

final class FeatureInteractor: FeatureInteracting {

    private var counter: Int = 0
    private let personInfoWorker: PersonInfoWork
    private let presenter: FeaturePresenting
    init(personInfoWorker: PersonInfoWork, presenter: FeaturePresenting) {
        self.personInfoWorker = personInfoWorker
        self.presenter = presenter
    }

    func handleOnAppear(request: Feature.OnAppear.Request) {
        presenter.presentOnAppear(response: .init(counter: counter))

        loadPersonInfo()
    }

    func handleDidTapMinusButton(request: Feature.DidTapMinusButton.Request) {
        counter -= 1

        presenter.presentDidTapMinusButton(response: .init(counter: counter))
    }

    func handleDidTapPlusButton(request: Feature.DidTapPlusButton.Request) {
        counter += 1

        presenter.presentDidTapPlusButton(response: .init(counter: counter))
    }

    func handleDidTapLoadPersonInfoButton(request: Feature.DidTapLoadPersonInfoButton.Request) {
        presenter.presentDidTapLoadPersonInfoButton(response: .init(isLoading: true))

        loadPersonInfo()
    }

    private func loadPersonInfo() {
        personInfoWorker.load { [weak self] personInfo in
            DispatchQueue.main.async {
                self?.presenter.presentDidLoadPersonInfo(response: .init(personInfo: personInfo))
            }
        }
    }
}
