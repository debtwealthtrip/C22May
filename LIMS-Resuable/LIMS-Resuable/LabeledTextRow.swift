//
//  LabeledTextRow.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/14/25.
//

import SwiftUI

/// A reusable component that shows:
/// 1. An optional label in smaller, underlined text (e.g., "Inspector")
/// 2. A main text (e.g., "Eddie Kim")
/// 3. An optional system image on the right
/// 4. A divider underneath
///
/// - Parameters:
///   - label: Optional label text shown above the main text (footnote style).
///   - text: The main text displayed in a larger/bolder style.
///   - systemImage: Optional SF Symbol name (e.g., "person.badge.plus").
////              Pass `nil` to hide the icon.
///   - iconColor: The color applied to the system image (default = `.blue`).
///   - iconAction: An optional closure that executes when the icon is tapped.
///
struct LabeledTextRow: View {
    // Configuration
    let label: String?
    let text: String
    let systemImage: String?
    let iconColor: Color
    let iconAction: (() -> Void)?
    
    init(
        label: String? = nil,
        text: String,
        systemImage: String? = nil,
        iconColor: Color = .blue,
        iconAction: (() -> Void)? = nil
    ) {
        self.label = label
        self.text = text
        self.systemImage = systemImage
        self.iconColor = iconColor
        self.iconAction = iconAction
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // 1. Optional Label
            if let label = label {
                Text(label)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .underline()
            }
            
            // 2. Main Text + Optional Icon
            HStack {
                Text(text)
                    .font(.headline)
                
                Spacer()
                
                if let systemImage = systemImage {
                    Button(action: {
                        iconAction?()
                    }) {
                        Image(systemName: systemImage)
                            .foregroundColor(iconColor)
                    }
                }
            }
            
            // 3. Divider
            Divider()
        }
    }
}


struct LabeledTextRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            
            // 1. With only label & text
            LabeledTextRow(
                label: "Inspector",
                text: "Eddie Kim"
            )
            
            // 2. With label, text and system Image
            LabeledTextRow(
                label: "Inspector 2",
                text: "Vivek Gollapally",
                systemImage: "person.badge.plus"
            )
            
            // 3. With label, text, custom icon color, and a tap action
            LabeledTextRow(
                label: "FL #",
                text: "12345",
                systemImage: "barcode.viewfinder",
                iconColor: .red
            ) {
                print("Icon tapped!")
            }
            
            // 4. No label, only text and icon
            LabeledTextRow(
                text: "Scan",
                systemImage: "qrcode.viewfinder"
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
