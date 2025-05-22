//
//  ContentView.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/9/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var showMap = false
   // let quadTree: EstablishmentQuadTree
   // let initialRegion: MKCoordinateRegion

    var body: some View {
        Button("Show Map") {
            showMap = true
        }
        .fullScreenCover(isPresented: $showMap) {
            MapWithBottomSheet()
        }
    }
}
