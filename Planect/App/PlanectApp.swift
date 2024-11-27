//
//  PlanectApp.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
// 
import SwiftUI
import SwiftData

@main
struct PlanectApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentScreen()
                .environment(\.themeManager, ThemeManager())
        }
    }
} 
