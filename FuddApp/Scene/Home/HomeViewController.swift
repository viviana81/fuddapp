//
//  ViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import UIKit
import PromiseKit

class HomeViewController: UIViewController {
        
    enum State {
        case idle
        case loading
        case loaded(main: [Restaurant], nextToYou: [Restaurant], nearest: [Restaurant])
        case error
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Restaurant>
    private lazy var datasource = dataSource
    
    var status: State = .idle {
        didSet {
            switch status {
            case .idle: break
            case .loading:
                loadingView.isHidden = false
            case .loaded(let main, let nextToYou, let nearest):
                loadingView.isHidden = true
                createSnapshot(withMain: main, lastViewed: nearest, nextToYou: nextToYou)
            case .error:
                print("error")

            }
        }
    }
    
    lazy var myCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collection.backgroundColor = .white
        collection.register(HomeCollectionViewCell.self)
        collection.register(HeaderView.self, forSupplementaryViewOfKind: "headerElementKind", withReuseIdentifier: HeaderView.reuseIdentifier)
        return collection
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myCollectionView.pin(to: view)
        loadingView.pin(to: view)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
       
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
           
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .main, .nextToYou:
                return self.mainLayout
            case .lastView:
                return self.lastViewedLayout
            }
          }
          return layout
    }
    
    var mainLayout: NSCollectionLayoutSection {
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
    
    var lastViewedLayout: NSCollectionLayoutSection {
        
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
    
    var dataSource: DataSource {
        
        let dataSource = DataSource(collectionView: myCollectionView, cellProvider: { (collectionView, indexPath, restaurant) ->
            UICollectionViewCell? in
            
            let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withRestaurant: restaurant)
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
        
        datasource.apply(snapshot, animatingDifferences: true)
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
