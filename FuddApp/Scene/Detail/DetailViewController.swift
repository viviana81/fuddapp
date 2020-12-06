//
//  DetailViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 06/12/20.
//

import UIKit

class DetailViewController: UIViewController {

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

    }
}
