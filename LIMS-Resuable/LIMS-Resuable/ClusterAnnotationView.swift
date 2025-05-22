//
//  ClusterAnnotationView.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/17/25.
//

// ClusterAnnotationView.swift

import SwiftUI

struct ClusterAnnotationView: View {
    let count: Int
    let isCluster: Bool
    let isSelected: Bool
    let action: () -> Void

    var diameter: CGFloat {
        let base: CGFloat = isCluster ? 32 : 24
        let extra = isCluster ? CGFloat(min(count, 10) * 4) : 0
        return isSelected ? (base + extra) * 1.15 : (base + extra)
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(isCluster ? Color.orange.opacity(0.85) : Color.blue.opacity(0.85))
                .frame(width: diameter, height: diameter)
            Circle()
                .stroke(isSelected ? Color.white : Color.black, lineWidth: 2)
                .frame(width: diameter, height: diameter)
            if isCluster {
                Text("\(count)")
                    .foregroundColor(.white)
                    .font(.system(size: CGFloat(min(12 + count, 20)), weight: .bold))
            } else {
                Image(systemName: "building.columns.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
            }
        }
        .shadow(radius: isSelected ? 4 : 2)
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isSelected)
        .onTapGesture(perform: action)
    }
}
