//
//  ErrorView.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 06/12/20.
//

import UIKit

class ErrorView: UIView {
    
    var onTapAction: (() -> Void)?
    
    lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.text = "Siamo spiacenti, si è verificato un errore"
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor.gray
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var retryButton: UIButton = {
        var button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        return button
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
        addSubview(errorLabel)
        addSubview(retryButton)
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 8)
        ])
    }
    
    @objc
    func retryAction() {
        onTapAction?()
    }
    
    func setError(_ error: String ) {
        errorLabel.text = error
    }
}
