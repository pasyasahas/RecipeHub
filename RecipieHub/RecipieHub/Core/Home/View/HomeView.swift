//
//  HomeView.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        ZStack() {
            // Background
            Color.customBackground.ignoresSafeArea()
            
            // Foreground
            ScrollView {
                
                VStack {
                    if viewModel.recipiesFetchError {
                        Spacer()
                        failureView
                        Spacer()
                    } else if viewModel.recipes.isEmpty {
                        Spacer()
                        emptyRecipeView
                        Spacer()
                    } else {
                        Recipes
                    }
                }
                
            }
            // Delete the cache memory and loading new data
            .refreshable {
                viewModel.deleteFolder()
                viewModel.fetchRecipes()
            }
            .navigationTitle("Recipies")
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(DeveloperPreview.preview.homeViewModel)
}

extension HomeView {
    
    // Dispalys list of recipies when recipies are succesfully fetched
    private var Recipes: some View {
        LazyVStack(spacing: 5) {
            ForEach(viewModel.recipes) { recipe in
                RecipieCard(recipe: recipe)
            }
            
        }
    }
    
    // Informes the user recipes are unavailable when the API data is empty
    private var emptyRecipeView: some View {
        VStack {
            Image(systemName: "xmark.bin.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("No recipes available at the moment")
                .font(.title)
                .foregroundColor(.customSecondaryText)
        }
    }
    
    // Informes the user there was an error fetching the data
    private var failureView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Failed to load recipes")
                .font(.title)
                .foregroundColor(.customSecondaryText)
        }
    }
}
