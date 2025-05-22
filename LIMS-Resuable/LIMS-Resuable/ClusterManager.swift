//
//  ClusterManager.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 5/16/25.
//

import MapKit

// Cluster annotation holding grouped members
final class Cluster: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let members: [MKAnnotation]

    var memberCount: Int { members.count }

    init(coordinate: CLLocationCoordinate2D, members: [MKAnnotation]) {
        self.coordinate = coordinate
        self.members = members
    }
}

// Fast, grid-based clustering manager
final class ClusterManager {
    private(set) var rawAnnotations: [MKAnnotation] = []
    private let workQueue = DispatchQueue(label: "com.example.cluster", qos: .userInitiated)

    func setAnnotations(_ annotations: [MKAnnotation]) {
        rawAnnotations = annotations
    }

    func clusterAnnotations(
        in visibleRect: MKMapRect,
        mapView: MKMapView,
        completion: @escaping ([MKAnnotation]) -> Void
    ) {
        workQueue.async {
            var grid = [GridKey: [MKAnnotation]]()
            let scale = Double(mapView.bounds.width) / visibleRect.size.width
            let cellSize = MKMapPointsPerMeterAtLatitude(mapView.centerCoordinate.latitude) * (4.0 / scale)

            for ann in self.rawAnnotations {
                let pt = MKMapPoint(ann.coordinate)
                guard visibleRect.contains(pt) else { continue }
                let key = GridKey(
                    x: Int(floor(pt.x / cellSize)),
                    y: Int(floor(pt.y / cellSize))
                )
                grid[key, default: []].append(ann)
            }

            var results: [MKAnnotation] = []
            for (_, members) in grid {
                if members.count == 1 {
                    results.append(members[0])
                } else {
                    let avgLat = members.reduce(0.0) { $0 + $1.coordinate.latitude } / Double(members.count)
                    let avgLon = members.reduce(0.0) { $0 + $1.coordinate.longitude } / Double(members.count)
                    results.append(Cluster(
                        coordinate: CLLocationCoordinate2D(latitude: avgLat, longitude: avgLon),
                        members: members
                    ))
                }
            }

            DispatchQueue.main.async { completion(results) }
        }
    }

    private struct GridKey: Hashable { let x: Int, y: Int }
}
