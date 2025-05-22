//
//  NutrientRow.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/14/25.
//

import SwiftUI

/// A row that shows a nutrient name on the left,
/// and three fields on the right: Min, Max, and %.
///
/// Example Usage:
///     NutrientRow(nutrientName: "Crude Protein")
///     NutrientRow(nutrientName: "Crude Fat")

struct NutrientRow: View {
    // The nutrient name displayed on the left (e.g., "Crude Protein")
    let nutrientName: String
    
    // Internal state for the three text fields.
    @State private var minValue: String = ""
    @State private var maxValue: String = ""
    @State private var percentValue: String = ""
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            // Left label: Nutrient name.
            Text(nutrientName)
                .font(.body)
                .frame(minWidth: 120, alignment: .leading)
            
            Spacer()
            
            // Right fields: Min, Max, %
            NutrientField(placeholder: "Min", text: $minValue)
            NutrientField(placeholder: "Max", text: $maxValue)
            NutrientField(placeholder: "%", text: $percentValue)
        }
        .padding(.vertical, 4)
    }
}

//  Subcomponent for each field

/// A stylized TextField with rounded borders and placeholder text.
fileprivate struct NutrientField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .frame(minWidth: 50)
    }
}



struct NutrientRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            NutrientRow(nutrientName: "Crude Protein")
            NutrientRow(nutrientName: "Crude Fat")
            NutrientRow(nutrientName: "Crude Fiber")
            NutrientRow(nutrientName: "Moisture")
            NutrientRow(nutrientName: "Ash")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
