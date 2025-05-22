//
//  SampleRowView.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/14/25.
//

import SwiftUI

/// A single row that displays:
/// - A "FL #" label and number
/// - A date string
/// - One or more tags (like "Listeria Monocytogenes", "Salmonella")
/// - A status icon and text aligned to the right
/// - A divider at the bottom
struct SampleRowView: View {
    
    
    
    /// A unique sample identifier (e.g., "399141").
    let sampleNumber: String
    
    /// A formatted date string (e.g., "1/28/2024, 11:57 AM").
    let dateString: String
    
    /// Tags to display (e.g., ["Listeria Monocytogenes", "Salmonella"]).
    let tags: [String]
    
    /// An optional SF Symbol name for the status icon (e.g., "clock.badge.check").
    /// If you’d like to omit the icon, pass `nil`.
    let statusIcon: String?
    
    /// A textual description of the status (e.g., "In Progress").
    let statusText: String
    
    /// The color used for the status icon and text.
    var statusColor: Color = .blue
    
 
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                
                // Left side: FL #, Date, and tags
                VStack(alignment: .leading, spacing: 4) {
                    Text("FL #: \(sampleNumber)")
                        .font(.headline)
                    
                    Text("Date: \(dateString)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Tags row
                    HStack {
                        ForEach(tags, id: \.self) { tag in
                            PillView(text: tag)
                        }
                    }
                }
                
                Spacer()
                
                // Right side: Icon + Status text
                VStack(alignment: .center, spacing: 4) {
                    if let icon = statusIcon {
                        Image(systemName: icon)
                            .foregroundColor(statusColor)
                            .symbolEffect(.variableColor)
                            
                    } 
                    
                    Text(statusText)
                        .font(.subheadline)
                        .foregroundColor(statusColor)
                }
            }
            
           
        }
    }
}

//  style tag
struct PillView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundColor(AppColors.primaryColor) // Customize text color
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(AppColors.primaryColor, lineWidth: 1) // Customize border color
            )
    }
}


struct SampleRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            
            SampleRowView(
                sampleNumber: "399141",
                dateString: "1/28/2024, 11:57 AM",
                tags: ["Listeria Monocytogenes", "Salmonella"],
                statusIcon: "rectangle.and.pencil.and.ellipsis",
                statusText: "In Progress",
                statusColor: .blue
            )
            
            SampleRowView(
                sampleNumber: "399131",
                dateString: "1/17/2024, 11:53 AM",
                tags: ["Listeria Monocytogenes", "Salmonella"],
                statusIcon: "checkmark.shield.fill",
                statusText: "Completed",
                statusColor: .orange
            )
            
            SampleRowView(
                sampleNumber: "399130",
                dateString: "1/17/2024, 11:51 AM",
                tags: ["Listeria Monocytogenes", "Salmonella"],
                statusIcon: "clock.arrow.trianglehead.2.counterclockwise.rotate.90",
                statusText: "Pending",
                statusColor: .yellow
            )
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
