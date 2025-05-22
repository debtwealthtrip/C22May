//
//  MapViewWrapper.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 5/15/25.
//
import SwiftUI
import MapKit

struct MapViewWrapper: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var annotations: [MKAnnotation]      // Your establishments as MKAnnotation
    var onClusterTap: ((Cluster) -> Void)?   // For cluster tap
    var onEstablishmentTap: ((MKAnnotation) -> Void)?

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: false)
        context.coordinator.clusterManager.setAnnotations(annotations)
        context.coordinator.cluster(on: mapView)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if !uiView.region.isApproximatelyEqual(to: region) {
            uiView.setRegion(region, animated: true)
        }
        context.coordinator.clusterManager.setAnnotations(annotations)
        context.coordinator.cluster(on: uiView)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewWrapper
        let clusterManager = ClusterManager()
        init(_ parent: MapViewWrapper) { self.parent = parent }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            DispatchQueue.main.async { self.parent.region = mapView.region }
            cluster(on: mapView)
        }

        func cluster(on mapView: MKMapView) {
            clusterManager.clusterAnnotations(
                in: mapView.visibleMapRect,
                mapView: mapView
            ) { newClusters in
                let toRemove = mapView.annotations.filter { !($0 is MKUserLocation) }
                mapView.removeAnnotations(toRemove)
                mapView.addAnnotations(newClusters)
            }
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if let cluster = annotation as? Cluster {
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: "ClusterView") as? MKMarkerAnnotationView
                    ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ClusterView")
                view.clusteringIdentifier = nil
                view.glyphText = "\(cluster.memberCount)"
                view.markerTintColor = .orange
                return view
            }
            // Regular pin
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "EstablishmentView") as? MKMarkerAnnotationView
                ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "EstablishmentView")
            view.clusteringIdentifier = nil
            view.glyphImage = UIImage(systemName: "building.columns.fill")
            view.markerTintColor = .orange
            return view
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let cluster = view.annotation as? Cluster {
                parent.onClusterTap?(cluster)
            } else if let est = view.annotation {
                parent.onEstablishmentTap?(est)
            }
        }
    }
}

// Helper for region equality
extension MKCoordinateRegion {
    func isApproximatelyEqual(to other: MKCoordinateRegion, tolerance: CLLocationDegrees = 0.0001) -> Bool {
        abs(center.latitude - other.center.latitude) < tolerance &&
        abs(center.longitude - other.center.longitude) < tolerance &&
        abs(span.latitudeDelta - other.span.latitudeDelta) < tolerance &&
        abs(span.longitudeDelta - other.span.longitudeDelta) < tolerance
    }
}
