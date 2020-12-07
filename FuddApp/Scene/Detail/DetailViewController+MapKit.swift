//
//  DetailViewController+MapKit.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 07/12/20.
//

import Foundation
import MapKit

extension DetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MapPoint else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.image = UIImage(named: "location-icon")
            annotationView!.canShowCallout = true
        
        } else {
            annotationView!.annotation = annotation
    
        }
        
        return annotationView
    }
}
