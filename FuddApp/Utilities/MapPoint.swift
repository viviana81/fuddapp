//
//  MapPoint.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 07/12/20.
//

import Foundation
import MapKit

class MapPoint: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(withTitle title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
