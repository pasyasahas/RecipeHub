//
//  RecipeServiceTests.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/24/24.
//


import XCTest
@testable import RecipieHub

final class RecipeServiceTests: XCTestCase {
    
    var recipeService: RecipeService!
    var mockFileManager: MockLocalFileManager!
    
    override func setUp() {
        super.setUp()
        mockFileManager = MockLocalFileManager()
        recipeService = RecipeService(fileManager: mockFileManager)
    }
    
    override func tearDown() {
        recipeService = nil
        mockFileManager = nil
        super.tearDown()
    }
    
    // Validate recipies succesfully fetched
    func testFetchRecipes_Success() async throws {
        let recipes = try await recipeService.fetchRecipes()
        
        XCTAssertNotNil(recipes)
        
    }
    
    // Validate Image fetched from cache
    func testGetRecipeImage_FetchFromCache() async throws {
        // Given
        let expectedImage = UIImage(systemName: "xmark.circle.fill")!
        mockFileManager.mockImages = ["testImage": expectedImage]
        
        // When
        let image = try await recipeService.getRecipeImage(for: "anyURL", imageName: "testImage")
        
        // Then
        XCTAssertEqual(image, expectedImage)
    }
    
    // Validate image fetched from network
    func testGetRecipeImage_FetchFromNetwork() async throws {
        
        let image = try await recipeService.getRecipeImage(
            for: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg",
            imageName: "Bakewell Tart")
        
        // Then
        XCTAssertNotNil(image)
    }
    
}
