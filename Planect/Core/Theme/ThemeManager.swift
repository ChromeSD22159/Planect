//
//  ThemeManager.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
//

import Foundation
import SwiftUI

@Observable
class ThemeManager: ObservableObject {
    /// Aktuelles Theme, das die UI beeinflusst
    var currentTheme: Theme = .defaultTheme

    init() {
        self.currentTheme = ThemeManager.getSavedTheme()
    }
    
    /// Setzt das Theme und speichert es
    func setTheme(_ theme: ThemeManager.Theme) {
        currentTheme = theme
        ThemeManager.saveTheme(theme)
    }
    
    /// Enum für Themes
    enum Theme: String, Codable {
        case defaultTheme = "Default"
        
        var displayName: String {
            switch self {
                case .defaultTheme: return "Default Theme"
            }
        }
    }
    
    /// Speichert das ausgewählte Theme in AppStorage
    static func saveTheme(_ theme: Theme) {
        @AppStorage("AppTheme") var savedTheme: String = theme.rawValue
        savedTheme = theme.rawValue
    }
    
    /// Lädt das gespeicherte Theme aus AppStorage
    private static func getSavedTheme() -> Theme {
        @AppStorage("AppTheme") var savedTheme: String = Theme.defaultTheme.rawValue
        return ThemeManager.Theme(rawValue: savedTheme) ?? .defaultTheme
    }
}
