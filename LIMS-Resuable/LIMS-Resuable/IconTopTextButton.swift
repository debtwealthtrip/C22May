//
//  IconTopTextButton.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/14/25.
//

import SwiftUI

/// A reusable button with an icon at the top and text at the bottom.
/// All buttons will have the same fixed size and use your custom primary color for the icon.
struct IconTopTextButton: View {
    // Configuration Parameters
    let systemImage: String
    let text: String
    
    /// Background color for the button.
    var backgroundColor: Color = Color.gray.opacity(0.2)
    
    /// Icon color defaults to your custom primary color.
    var iconColor: Color = AppColors.primaryColor
    
    /// Text color.
    var textColor: Color = Color.primary
    
    /// Corner radius for the button's background.
    var cornerRadius: CGFloat = 10
    
    /// Fixed size for all buttons.
    var fixedSize: CGSize = CGSize(width: 100, height: 60)
    
    /// Closure to execute on button tap.
    var action: (() -> Void)? = nil
    
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(iconColor)
                
                Text(text)
                    .font(.footnote)
                    .foregroundColor(iconColor)
            }
            .frame(width: fixedSize.width, height: fixedSize.height)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
        }
    }
}

struct IconTopTextButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 16) {
            IconTopTextButton(systemImage: "car.fill",
                              text: "8 Min",
                              backgroundColor: Color.gray.opacity(0.2)) {
                print("Car button tapped!")
            }
            
            IconTopTextButton(systemImage: "clipboard.fill",
                              text: "New Food",
                              backgroundColor: Color.gray.opacity(0.2)) {
                print("Clipboard button tapped!")
            }
            
          
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
