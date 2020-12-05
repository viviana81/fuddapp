//
//  Coordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 05/12/20.
//

import Foundation

protocol Coordinator {
    var coordinators: [Coordinator] { get set }
    func start()
}
