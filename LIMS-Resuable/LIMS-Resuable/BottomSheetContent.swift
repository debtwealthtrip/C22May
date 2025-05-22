//
//  BottomSheetContent.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/17/25.
//
import SwiftUI
import CoreLocation

/// Displays a scrollable list of hotels (defaults to all hotels in HotelsData)
struct BottomSheetContent: View {
    /// Inject or supply a custom list; default shows all
    let hotelList: [HotelsData.Hotel]

    /// Default initializer uses the full dataset
    init(hotelList: [HotelsData.Hotel] = HotelsData.list) {
        self.hotelList = hotelList
    }

    var body: some View {
        List(hotelList) { hotel in
            Text(hotel.name)
        }
    }
}


