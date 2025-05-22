////
////  EstablishmentQuadTree.swift
////  LIMS-Resuable
////
////  Created by Chaitanya Makkapati on 5/15/25.
////
//
//import MapKit
//
//class EstablishmentQuadTree {
//    let quadTree = FBQuadTree()
//
//    init(establishments: [Establishment]) {
//        for e in establishments {
//            let ann = EstablishmentAnnotation(establishment: e)
//            _ = quadTree.insert(annotation: ann)
//        }
//    }
//
//    func annotations(in region: MKCoordinateRegion) -> [EstablishmentAnnotation] {
//        let mapRect = MKMapRect(for: region)
//        let box = FBBoundingBox(mapRect: mapRect)
//        var found: [EstablishmentAnnotation] = []
//        quadTree.enumerateAnnotations(inBox: box) { annotation in
//            if let estAnn = annotation as? EstablishmentAnnotation {
//                found.append(estAnn)
//            }
//        }
//        return found
//    }
//}
//
//// Helper
//func MKMapRect(for region: MKCoordinateRegion) -> MKMapRect {
//    let center = region.center
//    let span = region.span
//    let topLeft = CLLocationCoordinate2D(
//        latitude: center.latitude + span.latitudeDelta/2,
//        longitude: center.longitude - span.longitudeDelta/2
//    )
//    let bottomRight = CLLocationCoordinate2D(
//        latitude: center.latitude - span.latitudeDelta/2,
//        longitude: center.longitude + span.longitudeDelta/2
//    )
//    let a = MKMapPoint(topLeft)
//    let b = MKMapPoint(bottomRight)
//    return MKMapRect(
//        origin: MKMapPoint(x: min(a.x, b.x), y: min(a.y, b.y)),
//        size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y))
//    )
//}
//
//extension EstablishmentQuadTree {
//    /// Pixel-based clustering for snappy performance
//    func clusteredAnnotations(in region: MKCoordinateRegion, mapView: MKMapView) -> [MKAnnotation] {
//        let visible = self.annotations(in: region)
//
//        // Early exit: if very zoomed in, just show all.
//        if mapView.region.span.latitudeDelta < 0.02 && mapView.region.span.longitudeDelta < 0.02 {
//            return visible
//        }
//
//        let cellSize: CGFloat = 60 // 60x60 pixels per cluster
//        var grid = [String: [EstablishmentAnnotation]]()
//
//        for ann in visible {
//            let coord = ann.coordinate
//            let point = mapView.convert(coord, toPointTo: mapView)
//            let x = Int(point.x / cellSize)
//            let y = Int(point.y / cellSize)
//            let key = "\(x)_\(y)"
//            grid[key, default: []].append(ann)
//        }
//
//        var results: [MKAnnotation] = []
//
//        for group in grid.values {
//            if group.count == 1 {
//                results.append(group[0])
//            } else {
//                // Compute average coordinate for cluster center
//                let coords = group.map { $0.coordinate }
//                let avgLat = coords.map { $0.latitude }.reduce(0, +) / Double(coords.count)
//                let avgLon = coords.map { $0.longitude }.reduce(0, +) / Double(coords.count)
//                let cluster = EstablishmentClusterAnnotation(
//                    coordinate: CLLocationCoordinate2D(latitude: avgLat, longitude: avgLon),
//                    memberAnnotations: group
//                )
//                results.append(cluster)
//            }
//        }
//        return results
//    }
//}
