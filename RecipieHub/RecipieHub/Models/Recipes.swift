//
//  Recipies.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import Foundation

struct Recipe: Codable {
    let recipes: [RecipeInfo]
}

struct RecipeInfo: Equatable, Identifiable, Codable {
    let id = UUID().uuidString
    let cuisine, name: String
    let photoURLLarge, photoURLSmall: String
    let uuid: String
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisine, name, uuid
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
