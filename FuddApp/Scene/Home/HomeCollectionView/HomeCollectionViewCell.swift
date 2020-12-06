//
//  HomeCollectionViewCell.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func configure(withRestaurant restaurant: Restaurant) {
        name.text = restaurant.name
        type.text = restaurant.type
        price.text = restaurant.price
        let url = URL(string: restaurant.image)
        image.kf.setImage(with: url)
    }
}
