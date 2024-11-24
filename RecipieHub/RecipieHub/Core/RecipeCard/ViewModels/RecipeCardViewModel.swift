//
//  RecipeCardViewModel.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import Foundation
import UIKit

@MainActor
final class RecipeCardViewModel: ObservableObject {
    let recipieService = RecipeService(fileManager: LocalFileManager())
    @Published var recipeImage: UIImage? = UIImage(systemName: "xmark.circle.fill") // Default image is specified in case no image exists
    
    init(recipe: RecipeInfo) {
        fetchRecipieImages(for: recipe)
    }
    
    func fetchRecipieImages(for recipe: RecipeInfo){
        Task{
            do{
                recipeImage = try await recipieService.getRecipeImage(for: recipe.photoURLSmall, imageName: recipe.name)
            } catch {
                print(error)
            }
        }
    }
    
}
