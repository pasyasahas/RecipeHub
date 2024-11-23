//
//  DeveloperPreview.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import Foundation
import UIKit


// Adding mock data for dependency injection to previews

@MainActor
final class DeveloperPreview {
    
    static let preview = DeveloperPreview()
    
    private init() {}
    
    let homeViewModel = HomeViewModel()
    
    let image = UIImage(systemName: "xmark.circle.fill")
    
    let recipe = RecipeInfo(
        cuisine: "British",
        name: "Bakewell Tart",
        photoURLLarge: "https://some.url/large.jpg",
        photoURLSmall: "https://some.url/small.jpg",
        uuid: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
        sourceURL: "https://some.url/index.html",
        youtubeURL: "https://www.youtube.com/watch?v=some.id"
    )
    
    
}


