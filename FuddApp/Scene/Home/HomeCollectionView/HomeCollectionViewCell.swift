//
//  HomeCollectionViewCell.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func configure(withRestaurant restaurant: Restaurant) {
        name.text = restaurant.name
        let url = URL(string: restaurant.image)
        image.kf.setImage(with: url)
    }
}
