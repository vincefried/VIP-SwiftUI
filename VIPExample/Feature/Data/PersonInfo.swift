//
//  PersonInfo.swift
//  VIPExample
//
//  Created by Vincent Friedrich on 14.01.23.
//

import Foundation

struct PersonInfo: Equatable, Decodable {
    let name: String
    let jobTitle: String
    let imageURL: String
    let websites: [String]
    let description: String
}
