//
//  SideMenuViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 29/12/20.
//

import UIKit
import SlideMenuControllerSwift

protocol SideMenuViewControllerDelegate: class {
    func goToLogout()
    func goToProfile()
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: SideMenuViewControllerDelegate?
    private let sideMenu: [MenuItem]
    private let user: User
    
    init(withDelegate delegate: SideMenuViewControllerDelegate, user: User) {
        self.delegate = delegate
       
        let sideMenu = [
            MenuItem(title: "Logout", icon: "power", action: delegate.goToLogout),
            MenuItem(title: "Le mie prenotazioni", icon: "book", action: nil),
            MenuItem(title: "I miei preferiti", icon: "heart", action: nil),
            MenuItem(title: "Il mio profilo", icon: "person", action: delegate.goToProfile)
        ]
        
        self.sideMenu = sideMenu
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeMenu))
        tableView.register(SideMenuTableViewCell.self)
        nameLabel.text = "Bentornato \(user.name)"
    }
    
    @objc
    func closeMenu() {
        self.slideMenuController()!.closeRight()
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let item = sideMenu[indexPath.row]
        cell.configure(withItem: item)
        return cell
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sideMenu[indexPath.row]
        item.action?()
    }
}
