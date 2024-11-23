//
//  LaunchView.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/22/24.
//


import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Hang tight 👨🏻‍🍳".map{ String($0)}
    @State private var showLoadingText: Bool = false
    private let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.customAccent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    loadingText = "Recipies on your way...".map{ String($0)}
                    if loops >= 2{
                        showLaunchView = false
                    }
                } else{
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
