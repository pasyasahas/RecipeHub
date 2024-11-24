//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Pasya Sahas on 10/28/24.
//

import Foundation
import SwiftUI

// Adding custom color theme
extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    let customAccent = Color("CustomAccentColor")
    let customBackground = Color("CustomBackgroundColor")
    let customGreen = Color("CustomGreenColor")
    let customRed = Color("CustomRedColor")
    let customSecondaryText = Color("CustomSecondaryTextColor")
}

