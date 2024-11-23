//
//  RecipieHubApp.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//

import SwiftUI

@main
struct RecipieHubApp: App {
    
    @StateObject private var homeViewModel = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init () {
        
        // Adds accent color to Navigation Bar title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.customAccent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationStack {
                    HomeView()
                }
                .environmentObject(homeViewModel)
                
                // Displays the launch View
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
            .onDisappear {
                homeViewModel.deleteFolder()
            }
        }
    }
}
