//
//  Establishment.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 5/15/25.
//

import Foundation
import MapKit

struct Establishment: Identifiable, Decodable {
    let id: UUID
    let address: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "UUID"
        case address
        case latitudes
        case longitudes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID(uuidString: try container.decode(String.self, forKey: .id)) ?? UUID()
        address = try container.decode(String.self, forKey: .address)
        latitude = Double(try container.decode(String.self, forKey: .latitudes)) ?? 0.0
        longitude = Double(try container.decode(String.self, forKey: .longitudes)) ?? 0.0
    }
}

class EstablishmentAnnotation: NSObject, MKAnnotation {
    let establishment: Establishment
    var coordinate: CLLocationCoordinate2D { establishment.coordinate }
    var title: String? { establishment.address }
    init(establishment: Establishment) {
        self.establishment = establishment
    }
}

func loadEstablishments() -> [Establishment] {
    guard let url = Bundle.main.url(forResource: "output_strings_objects", withExtension: "json"),
          let data = try? Data(contentsOf: url) else { return [] }
    let decoder = JSONDecoder()
    return (try? decoder.decode([Establishment].self, from: data)) ?? []
}
