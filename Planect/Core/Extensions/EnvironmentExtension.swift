//
//  EnvironmentExtension.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
//

import SwiftUICore

struct ThemeManagerKey: EnvironmentKey {
    static let defaultValue = ThemeManager()
}

extension EnvironmentValues {
    var themeManager: ThemeManager {
        get { self[ThemeManagerKey.self] }
        set { self[ThemeManagerKey.self] = newValue }
    }
}
