//
//  HomeCoordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 05/12/20.
//

import UIKit
import PromiseKit

class HomeCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let homeViewController: HomeViewController
    private let services: Services
    let navigation: UINavigationController
    var window: UIWindow
    
    init(services: Services, window: UIWindow) {
        self.services = services
        self.window = window
        homeViewController = HomeViewController()
        self.navigation = UINavigationController(rootViewController: homeViewController)
    
    }

    func start() {
    
        window.rootViewController = navigation
        
        getData()
    }
    
    private func getData() {
        let favouritePromise = getFavourite()
        let mainPromise = getMain()
        let nextPromise = getNexToYou()
        
        homeViewController.status = .loading
        
        firstly {
            when(fulfilled: favouritePromise, mainPromise, nextPromise)
        }.done { favourites, nearest, nextToYou in
            self.homeViewController.status = .loaded(main: favourites, nextToYou: nextToYou, nearest: nearest)
        }.catch { error in
            self.homeViewController.status = .error
            print(error)
        }
    }
    
    private func getFavourite() -> Promise<[Restaurant]> {
        
        return Promise<[Restaurant]> { seal in
            
            services.getFavourite { (favouriteRestaurants, error) in
                if let favouriteRestaurants = favouriteRestaurants {
                    seal.fulfill(favouriteRestaurants)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    private func getMain() -> Promise<[Restaurant]> {
        
        return Promise<[Restaurant]> { seal in
            
            services.getMain { (mains, error) in
                if let mains = mains {
                    seal.fulfill(mains)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    private func getNexToYou() -> Promise<[Restaurant]> {
        
        return Promise<[Restaurant]> { seal in
            
            services.getNexToYou { (nexToYou, error) in
                if let nexToYou = nexToYou {
                    seal.fulfill(nexToYou)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
}
