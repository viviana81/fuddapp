//
//  ErrorView.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 06/12/20.
//

import UIKit

class ErrorView: UIView {
    
    lazy var error: UILabel = {
        var label = UILabel()
        label.text = "Siamo spiacenti, si è verificato un errore"
        label.font = UIFont(name: "System", size: 28)
        label.textColor = UIColor.gray
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configureUI()
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(error)
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            error.centerYAnchor.constraint(equalTo: centerYAnchor),
            error.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
