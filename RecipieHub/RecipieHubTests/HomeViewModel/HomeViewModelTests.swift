//
//  HomeViewModelTests.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/24/24.
//

import XCTest
@testable import RecipieHub
import UIKit

@MainActor
final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockService: MockRecipeService!

    override func setUpWithError() throws {
        mockService = MockRecipeService()
        
        viewModel = HomeViewModel(recipeService: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }

    // Validate fetching recipies
    func testFetchRecipesSuccess() async throws {
        
        let mockRecipe = RecipeInfo(
            cuisine: "British",
            name: "Bakewell Tart",
            photoURLLarge: "https://some.url/large.jpg",
            photoURLSmall: "https://some.url/small.jpg",
            uuid: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
            sourceURL: "https://some.url/index.html",
            youtubeURL: "https://www.youtube.com/watch?v=some.id"
        )
        mockService.mockRecipes = [mockRecipe]
        mockService.shouldFailFetchingRecipes = false
        XCTAssertNoThrow(viewModel.fetchRecipes())
    }
    
    // Validate failure fetching recipes
    func testFetchRecipesFailure() async throws {
        mockService.shouldFailFetchingRecipes = true
        
        viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.recipes.count, 0)
    }

    
    // VAlidate folder deletion
    func testDeleteFolder() {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let testFolderURL = cacheDirectory.appendingPathComponent("recipie_images")
        
        try? FileManager.default.createDirectory(at: testFolderURL, withIntermediateDirectories: true, attributes: nil)
        XCTAssertTrue(FileManager.default.fileExists(atPath: testFolderURL.path))
        
        viewModel.deleteFolder()
        XCTAssertFalse(FileManager.default.fileExists(atPath: testFolderURL.path))
    }
}
