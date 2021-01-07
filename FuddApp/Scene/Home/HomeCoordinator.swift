//
//  HomeCoordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 05/12/20.
//

import UIKit
import PromiseKit
import SlideMenuControllerSwift

class HomeCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let homeViewController: HomeViewController
    private let services: Services
    let navigation: UINavigationController
    var window: UIWindow
    let user: User
    let sideMenu: SideMenuViewController
    
    init(services: Services, window: UIWindow, user: User, sideMenu: SideMenuViewController) {
        self.services = services
        self.window = window
        self.user = user
        self.sideMenu = sideMenu
        homeViewController = HomeViewController()
        self.navigation = UINavigationController(rootViewController: homeViewController)
    
    }

    func start() {
    
        let slideMenu = SlideMenuController(mainViewController: navigation, leftMenuViewController: sideMenu)
        homeViewController.delegate = self
        window.rootViewController = slideMenu
        getData()
    }
    
    private func getData() {
        let favouritePromise = getFavourite()
        let mainPromise = getMain()
        let nextPromise = getNexToYou()
        
        homeViewController.status = .loading
        
        firstly {
            when(fulfilled: mainPromise, favouritePromise, nextPromise)
        }.done { main, favourite, nextToYou in
            self.homeViewController.status = .loaded(main: main, favourite: favourite, nextToYou: nextToYou)
        }.catch { error in
            self.homeViewController.status = .error(message: error.localizedDescription)
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

extension HomeCoordinator: HomeViewControllerDelegate {
    func userDidTapOnRetryButton() {
        getData()
    }
    
    func userDidTapOnRestaurant(_ restaurant: Restaurant) {
        let detail = DetailViewController(restaurant: restaurant)
        homeViewController.navigationController?.pushViewController(detail, animated: true)
    }
}
