//
//  Double.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 07/12/20.
//

import Foundation

extension Double {
    
    var stringValue: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
