//
//  ComponentTypes.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/15/25.
//

import SwiftUI

enum ComponentType {
    case email(text: Binding<String>)
    case password(text: Binding<String>, faceIDAction: () -> Void)
    case loginButton(action: () -> Void)
    
}

enum IconTextButtonType {
    case button
    case menu
}

/// A simple view for a menu item that shows a checkmark when the item is selected.
struct MenuItemButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            // When selected, show the checkmark.
            if isSelected {
                Label(title, systemImage: "checkmark")
            } else {
                Text(title)
            }
        }
    }
}
