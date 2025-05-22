// HotelData.swift

import Foundation
import CoreLocation
import MapKit

/// Loads your hotel JSON and exposes a typed array of `Hotel`
struct HotelsData {
    struct Hotel: Identifiable, Hashable {
        let id: UUID
        let name: String
        let coordinate: CLLocationCoordinate2D

        func hash(into hasher: inout Hasher) { hasher.combine(id) }
        static func ==(lhs: Hotel, rhs: Hotel) -> Bool { lhs.id == rhs.id }
    }

    static var list: [Hotel] = {
        guard let url = Bundle.main.url(
                forResource: "output_strings",
                withExtension: "json")
        else {
            print("❌ Missing output_strings.json")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            struct RawHotel: Codable {
                let UUID: String, address: String
                let latitudes: String, longitudes: String
            }
            let decoder = JSONDecoder()

            // Try decode array of objects, else array of JSON-strings
            let rawHotels: [RawHotel]
            if let objs = try? decoder.decode([RawHotel].self, from: data) {
                rawHotels = objs
            } else {
                let jsonStrings = try decoder.decode([String].self, from: data)
                rawHotels = jsonStrings.compactMap {
                    guard let d = $0.data(using: .utf8),
                          let obj = try? decoder.decode(RawHotel.self, from: d)
                    else { return nil }
                    return obj
                }
            }

            // Map to typed Hotel
            return rawHotels.compactMap { r in
                guard let uuid = UUID(uuidString: r.UUID),
                      let lat = Double(r.latitudes),
                      let lon = Double(r.longitudes)
                else { return nil }
                return Hotel(
                  id: uuid,
                  name: r.address,
                  coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)
                )
            }
        } catch {
            print("❌ JSON error:", error)
            return []
        }
    }()
}

/// A thin MKAnnotation wrapper so we can insert hotels into the quad tree
class HotelAnnotation: NSObject, MKAnnotation {
    let hotel: HotelsData.Hotel
    var coordinate: CLLocationCoordinate2D { hotel.coordinate }
    var title: String? { hotel.name }
    init(hotel: HotelsData.Hotel) { self.hotel = hotel }
}

