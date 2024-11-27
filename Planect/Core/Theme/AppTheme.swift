//
//  AppColors.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
//

import SwiftUI
   
struct AppTheme {
    static let colors = AppColors.self
    static let typography = AppTypography.self
    static let spacing = AppSpacing.self
}

struct AppColors {
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let background = Color("Background")
    static let text = Color("Text")
}

struct AppTypography {
    static let heading = Font.system(size: 24, weight: .bold, design: .default)
    static let body = Font.system(size: 16, weight: .regular, design: .default)
    static let caption = Font.system(size: 12, weight: .light, design: .default)
}

struct AppSpacing {
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
}
