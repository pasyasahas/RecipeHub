//
//  MockRecipeService.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/24/24.
//


import XCTest
@testable import RecipieHub
import UIKit

class MockRecipeService: RecipeServiceProtocol {
    var shouldFailFetchingRecipes = false
    var shouldFailFetchingImage = false
    var mockRecipes: [RecipeInfo] = []
    var mockImage: UIImage? = UIImage(systemName: "checkmark.circle.fill")
    
    func fetchRecipes() async throws -> [RecipeInfo] {
        if shouldFailFetchingRecipes {
            throw URLError(.badServerResponse)
        }
        return mockRecipes
    }
    
    func getRecipeImage(for photoURL: String, imageName: String) async throws -> UIImage? {
        if shouldFailFetchingImage {
            throw URLError(.badURL)
        }
        return mockImage
    }
}
