//
//  SideMenuTableViewCell.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 29/12/20.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func configure(withItem item: MenuItem) {
        titleLabel.text = item.title
        icon.image = UIImage(systemName: item.icon)
    }
}
