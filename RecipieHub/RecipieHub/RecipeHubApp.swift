//
//  RecipieHubApp.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import SwiftUI

@main
struct RecipeHubApp: App {
    
    init () {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.customAccent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
        }
    }
}
