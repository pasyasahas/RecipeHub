//
//  RecipieCard.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import SwiftUI

struct RecipieCard: View {
    
    @StateObject private var viewModel: RecipeCardViewModel
    @State private var showAdditionalInfo: Bool = false
    let recipe: RecipeInfo
    
    init(recipe: RecipeInfo) {
        self.recipe = recipe
        _viewModel = StateObject(wrappedValue: RecipeCardViewModel(recipe: recipe))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            RecipieInfo
            if showAdditionalInfo {
                AdditionalInfo
            }
        }
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(10)
        .shadow(color: .customAccent.opacity(0.5), radius: 10)
    }
}

#Preview {
    RecipieCard(recipe: DeveloperPreview.preview.recipe)
}

extension RecipieCard {
    
    // Displayes recipe  information
    private var RecipieInfo: some View {
        HStack(spacing: 10) {
            RecipieImage
            RecipieAndCusine
            Spacer()
            ShowAdditionalInfo
        }
        
    }
    
    // Displays Recipie Image
    private var RecipieImage: some View {
        Image(uiImage: viewModel.recipeImage! )
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .padding(10)
    }
    
    // Displays the recipie name and cusine
    private var RecipieAndCusine: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .lineLimit(showAdditionalInfo ? 3 : 1)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.customAccent)
            Text(recipe.cuisine)
                .lineLimit(1)
                .font(.title3)
                .foregroundStyle(Color.customRed)
        }
    }
    
    // Aids in displaying additional info
    private var ShowAdditionalInfo: some View {
        VStack(spacing: 10) {
            Text(showAdditionalInfo ? "Show less" : "Show More")
                .font(.caption)
                .foregroundStyle(Color.customSecondaryText)
            Image(systemName: "chevron.down")
                .rotationEffect(Angle(degrees: showAdditionalInfo ? 180 : 0))
        }
        .padding(10)
        .onTapGesture {
            withAnimation(.spring()) {
                showAdditionalInfo.toggle()
            }
        }
    }
    
    // Displays the website and youtube links if available
    private var AdditionalInfo: some View {
        VStack(alignment: .leading,spacing: 10) {
            if let websiteURL = recipe.sourceURL,
               let url = URL(string: websiteURL) {
                Text("Find more information on the website:")
                Link("Website", destination: url)
            }
            if let youtubeURL = recipe.youtubeURL,
               let url = URL(string: youtubeURL) {
                Text("Find a video on YouTube:")
                Link("Youtube", destination: url)
            }
        }
        .padding()
    }
    
}
