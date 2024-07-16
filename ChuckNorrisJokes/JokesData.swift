//
//  JokesData.swift
//  ChuckNorrisJokes
//
//  Created by Mehmet Ali Bunsuz on 16.07.2024.
//

import Foundation

struct ChuckNorrisJoke: Codable, Identifiable {
    let categories: [String]
    let createdAt: String
    let iconURL: String
    let id: String
    let updatedAt: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case categories
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case id
        case updatedAt = "updated_at"
        case url
        case value
    }
}
