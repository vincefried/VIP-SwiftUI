//
//  PersonInfoWorker.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import Combine
import Foundation

protocol PersonInfoWork {
    func load(completionHandler: @escaping (PersonInfo) -> Void)
}

final class PersonInfoWorker: PersonInfoWork {
    private var cancellables = Set<AnyCancellable>()

    func load(completionHandler: @escaping (PersonInfo) -> Void) {
        guard let url = URL(string: "https://adalbertapi.neoxapps.de/aboutme") else { return }

        let session = URLSession.shared
        session.dataTaskPublisher(for: url)
            .delay(for: 1.0, scheduler: DispatchQueue.main) // artificial delay to visualize loading
            .sink { _ in
            } receiveValue: { data, _ in
                let decoder = JSONDecoder()

                guard let response = try? decoder.decode(PersonInfo.self, from: data) else { return }

                completionHandler(response)
            }
            .store(in: &cancellables)
    }
}
