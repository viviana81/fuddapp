//
//  ViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import UIKit
import PromiseKit

class HomeViewController: UIViewController {
        
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Restaurant>
    private  lazy  var dataSource = makeDataSource ()
    let services = MockServices()
    
    lazy var myCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")
        collection.register(HeaderView.self, forSupplementaryViewOfKind: "headerElementKind", withReuseIdentifier: HeaderView.reuseIdentifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myCollectionView)
        
        NSLayoutConstraint.activate([
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            myCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        getData()
    }
    
    func getData() {
        let favouritePromise = getFavourite()
        let mainPromise = getMain()
        let nextPromise = getNexToYou()
        
        // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        firstly {
            when(fulfilled: favouritePromise, mainPromise, nextPromise)
        }.done { favourites, nearest, nextToYou in
            self.createSnapshot(withMain: favourites, lastViewed: nearest, nextToYou: nextToYou)
        }.ensure {
            // UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }.catch { error in
            print(error)
        }
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
       
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
              -> NSCollectionLayoutSection? in
           
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .main, .nextToYou:
                return self.makeMainLayout()
            case .lastView:
                return self.makeLastViewedLayout()
            }
          }
          return layout
    }
    
    func makeMainLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.80),
                                               heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 0,
            trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: "headerElementKind",
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func makeLastViewedLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
       
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(186),
            heightDimension: .absolute(186))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 0,
            trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: "headerElementKind",
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func makeDataSource() -> DataSource {
        
        let dataSource = DataSource(collectionView: myCollectionView, cellProvider: { (collectionView, indexPath, restaurant) ->
            UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "homeCell",
                for: indexPath) as? HomeCollectionViewCell
            cell?.configure(withRestaurant: restaurant)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderView.reuseIdentifier,
                    for: indexPath) as? HeaderView else {
                fatalError("Cannot create header view")
            }
            
            supplementaryView.label.text = Section.allCases[indexPath.section].header
            
            return supplementaryView
        }
        
        return dataSource
    }
    
    func createSnapshot(withMain main: [Restaurant], lastViewed: [Restaurant], nextToYou: [Restaurant]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(main, toSection: .main)
        snapshot.appendItems(lastViewed, toSection: .lastView)
        snapshot.appendItems(nextToYou, toSection: .nextToYou)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func getFavourite() -> Promise<[Restaurant]> {
        
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
    
    func getMain() -> Promise<[Restaurant]> {
        
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
    
    func getNexToYou() -> Promise<[Restaurant]> {
        
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

extension HomeViewController {
    
    enum Section: CaseIterable {
        case main
        case lastView
        case nextToYou
        
        var header: String {
            switch self {
            case .main:
                return "Le migliori recensioni"
            case .lastView:
                return "Ultimi visualizzati"
            case .nextToYou:
                return "Attorno a te"
            }
        }
    }
}
