//
//  DetailViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 06/12/20.
//

import UIKit
import Kingfisher
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var restaurantMap: MKMapView!
    
    private let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = restaurant.name
        let url = URL(string: restaurant.image)
        imageRestaurant.kf.setImage(with: url)
        descriptionLabel.text = restaurant.description
        addressLabel.text = restaurant.address
        
        let restaurantPoint = MapPoint(withTitle: restaurant.name, subtitle: restaurant.address, coordinate: CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude))
        
        restaurantMap.addAnnotation(restaurantPoint)
        restaurantMap.showAnnotations(self.restaurantMap.annotations, animated: true)
    
    }
}
