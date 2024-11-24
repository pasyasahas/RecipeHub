//
//  RecipeCardViewModelTests.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/24/24.
//

import XCTest
@testable import RecipieHub
import UIKit

@MainActor
final class RecipeCardViewModelTests: XCTestCase {
    var viewModel: RecipeCardViewModel!
    var mockService: MockRecipeService!
    let sampleRecipe = RecipeInfo(
        cuisine: "British",
        name: "Bakewell Tart",
        photoURLLarge: "https://some.url/large.jpg",
        photoURLSmall: "https://some.url/small.jpg",
        uuid: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
        sourceURL: "https://some.url/index.html",
        youtubeURL: "https://www.youtube.com/watch?v=some.id"
    )
    let sampleRecipe2 = RecipeInfo(
        cuisine: "British",
        name: "Bakewell Tart",
        photoURLLarge: "https://some.url/large.jpg",
        photoURLSmall: "https://failurl",
        uuid: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
        sourceURL: "https://some.url/index.html",
        youtubeURL: "https://www.youtube.com/watch?v=some.id"
    )
    
    override func setUpWithError() throws {
        viewModel = RecipeCardViewModel(recipe: sampleRecipe)
        mockService = MockRecipeService()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }

    // Validate image succesfully fetched
    func testFetchRecipeImageSuccess() async throws {
        mockService.shouldFailFetchingImage = false
        
        viewModel.fetchRecipieImages(for: sampleRecipe)
        
        XCTAssertNotNil(viewModel.recipeImage)
    }

    // Validate image is default image when fetch failed
    func testFetchRecipeImageFailure() async throws {
        // Configure the mock service for failure
        mockService.shouldFailFetchingImage = true
        
        viewModel.fetchRecipieImages(for: sampleRecipe2)
        
        XCTAssertEqual(viewModel.recipeImage, UIImage(systemName: "xmark.circle.fill"), "The recipe image should remain the default image on failure.")
    }
}
