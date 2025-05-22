//
//  InputFieldStyle.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/15/25.
//
import SwiftUI

struct InputFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.gray, lineWidth: 1)
            )
    }
}


extension View {
    func inputFieldStyle() -> some View {
        self.modifier(InputFieldStyle())
    }
}

