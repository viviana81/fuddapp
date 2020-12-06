//
//  HeaderView.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 29/11/20.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "supplementary-header-reusable-view"
    static let kind = "supplementary-header-reusable-kind"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    enum Constants {
        static let padding: CGFloat = 20.0
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
