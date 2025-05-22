//
//  SwiftUIAnyAnnotationView.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 5/16/25.
//

import MapKit
import SwiftUI

class SwiftUIAnyAnnotationView: MKAnnotationView {
    private var hostingController: UIHostingController<ClusterAnnotationView>?

    func configure(count: Int, isCluster: Bool, isSelected: Bool, action: @escaping () -> Void) {
        let view = ClusterAnnotationView(count: count, isCluster: isCluster, isSelected: isSelected, action: action)
        if let hostingController = hostingController {
            hostingController.rootView = view
        } else {
            let controller = UIHostingController(rootView: view)
            controller.view.backgroundColor = UIColor.clear
            self.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                controller.view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                controller.view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            hostingController = controller
        }
        let d: CGFloat = view.diameter
        self.frame = CGRect(x: 0, y: 0, width: d, height: d)
        self.centerOffset = CGPoint(x: 0, y: -d / 2)
    }
}
