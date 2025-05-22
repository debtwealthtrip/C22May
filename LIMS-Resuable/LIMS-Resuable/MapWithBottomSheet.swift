//
//  MapWithBottomSheet.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/17/25.
//

//@State private var allEstablishments: [EstablishmentAnnotation] = []
//init(quadTree: EstablishmentQuadTree, initialRegion: MKCoordinateRegion) {
//self.quadTree = quadTree
//_region = State(initialValue: initialRegion)
//// This collects all establishments from the quadTree (assume you expose allEstablishments in quadTree or get from your source)
//_allEstablishments = State(initialValue: quadTree.annotations(in: initialRegion)) // Or however you get all
//}
//.sheet(isPresented: .constant(true)) {
//    BottomSheet(
//        allAnnotations: $allEstablishments,
//        visibleAnnotations: $visibleAnnotations,
//        selectedAnnotation: $selectedAnnotation,
//        region: $region
//    )
//    // ...
//}

import SwiftUI
import MapKit

struct MapWithBottomSheet: View {
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.55369, longitude: -76.14035),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    @State private var allAnnotations: [EstablishmentAnnotation] = []
    @State private var selectedCluster: Cluster?
    @State private var selectedAnnotation: EstablishmentAnnotation?
    @State private var showSheet = false

    let establishments: [Establishment] = loadEstablishments()

    var body: some View {
        ZStack {
            MapViewWrapper(
                region: $region,
                annotations: allAnnotations,
                onClusterTap: { cluster in
                    selectedCluster = cluster
                    selectedAnnotation = nil
                    showSheet = true
                },
                onEstablishmentTap: { ann in
                    if let estAnn = ann as? EstablishmentAnnotation {
                        selectedCluster = nil
                        selectedAnnotation = estAnn
                        showSheet = true
                    }
                }
            )
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            allAnnotations = establishments.map { EstablishmentAnnotation(establishment: $0) }
            showSheet = true // Show all on launch
        }
        .sheet(isPresented: $showSheet) {
            BottomSheet(
                allAnnotations: allAnnotations,
                selectedCluster: selectedCluster,
                selectedAnnotation: $selectedAnnotation,
                region: $region
            )
        }
    }
}

struct BottomSheet: View {
    let allAnnotations: [EstablishmentAnnotation]
    let selectedCluster: Cluster?
    @Binding var selectedAnnotation: EstablishmentAnnotation?
    @Binding var region: MKCoordinateRegion

    var currentList: [EstablishmentAnnotation] {
        if let cluster = selectedCluster {
            return cluster.members.compactMap { $0 as? EstablishmentAnnotation }
        } else if let selected = selectedAnnotation {
            return [selected]
        } else {
            return allAnnotations
        }
    }

    var body: some View {
        List(currentList, id: \.establishment.id) { ann in
            Text(ann.establishment.address)
                .font(selectedAnnotation == ann ? .headline : .body)
                .foregroundColor(selectedAnnotation == ann ? .blue : .primary)
                .background(selectedAnnotation == ann ? Color.blue.opacity(0.1) : Color.clear)
                .onTapGesture {
                    selectedAnnotation = ann
                    region.center = ann.coordinate
                    region.span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                }
        }
        .presentationDetents([ .medium, .large])
    }
}
