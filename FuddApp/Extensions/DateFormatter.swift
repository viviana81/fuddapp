//
//  DateFormatter.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 30/12/20.
//

import Foundation

extension DateFormatter {
    
    static var APIDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}
