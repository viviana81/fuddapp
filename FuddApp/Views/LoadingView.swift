//
//  LoadingView.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 05/12/20.
//

import UIKit

class LoadingView: UIView {
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    init() {
        super.init(frame: .zero)
        configureUI()
        configureConstraints()
        loader.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(loader)
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
