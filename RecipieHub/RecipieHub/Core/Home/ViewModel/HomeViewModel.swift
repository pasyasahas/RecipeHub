//
//  HomeViewModel.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import Foundation
import UIKit

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var recipiesFetchError: Bool = false // Indicates if the API data is invalid or unable to fetch data
    @Published var recipes: [RecipeInfo] = []
    @Published var recipeImage: UIImage? = nil
    let recipieService = RecipeService()
    
    
    init() {
        fetchRecipes()
    }
    
    // Fetch recipies using the recipieService
    func fetchRecipes() {
        Task{
            do{
                recipes = try await recipieService.fetchRecipes()
            } catch {
                recipiesFetchError = true
            }
        }
    }
    
    func deleteFolder() {
        // Delete folder containing catch images
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent("recipie_images")
        else { return }
        try? FileManager.default.removeItem(at: url)
    }
    
}

extension HomeViewModel {
    
    // Custom errors for Recipie fetcing
    enum RecipeFetchError: LocalizedError {
        case errorFetchingRecipes
        
        var errorDescription: String? {
            switch self {
            case .errorFetchingRecipes: return "[⚠️] Error fetching recipes"
            }
        }

    }
    
}
