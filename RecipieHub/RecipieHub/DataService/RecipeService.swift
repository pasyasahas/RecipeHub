//
//  RecipieService.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import Foundation
import UIKit

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [RecipeInfo]
    
    func getRecipeImage(for photoURL: String, imageName: String) async throws -> UIImage?
}

actor RecipeService: RecipeServiceProtocol, ObservableObject {
    let fileManager: LocalFileManagerProtocol = LocalFileManager.instance
    let folderName: String = "recipie_images"
    let API: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    // Fetch recipies from the API
    func fetchRecipes() async throws -> [RecipeInfo] {
        guard let url = URL(string: API) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard
            let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        do{
            let recipes = try JSONDecoder().decode(Recipe.self, from: data)
            return recipes.recipes
        } catch {
            throw NetworkingError.failedToDecodeRecipes
        }
        
    }
    
    // Fetch Image for each recipie
    func getRecipeImage(for photoURL: String, imageName: String) async throws -> UIImage? {
        
        // Check if image exists in FileManager cache directory, if yes fetch it
        if let savedImage =  await fileManager.getImage(imageName: imageName, folderName: folderName){
            return savedImage
        } else {
            
            // If image not in file directory fetch image from the internet
            do{
                let image = try await fetchRecipieImage(for: photoURL)
                guard let image = image else {
                    throw NetworkingError.failedToFetchImage
                }
                try await fileManager.saveImage(image: image, imageName: imageName, folderName: folderName)
                return image
            } catch {
                throw NetworkingError.failedToFetchImage
            }
        }
        
    }
    
    
    // Fetch the image from the API using the photoURLSmall value
    func fetchRecipieImage(for photoURL: String) async throws -> UIImage? {
        guard let url = URL(string: photoURL) else {
            throw NetworkingError.URLConversionFailed
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard
            let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        guard
            let image = UIImage(data: data) else {
            throw NetworkingError.imageConversionFailed
        }
        return image
    }
    
    
}

extension RecipeService {
    
    // Custom errors for RecipeService operations
    enum NetworkingError: Equatable, LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        case URLConversionFailed
        case imageConversionFailed
        case failedToFetchImage
        case failedToDecodeRecipes
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[❌] Bad Response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            case .URLConversionFailed: return "[⚠️] Couldn't convert the string to URL"
            case .imageConversionFailed: return "[⚠️] Couldn't convert the image data to UIImage"
            case .failedToFetchImage: return "[❌] Failed to fetch image from URL"
            case .failedToDecodeRecipes: return "[❌] Failed to decode recipes MALFORMED JSON"
            }
        }
    }
    
    
}
