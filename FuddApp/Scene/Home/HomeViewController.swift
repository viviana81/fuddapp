//
//  ViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import UIKit
import PromiseKit

protocol HomeViewControllerDelegate: class {
    func userDidTapOnRetryButton()
    func userDidTapOnRestaurant(_ restaurant: Restaurant)
}

class HomeViewController: UIViewController {
        
    enum State {
        case idle
        case loading
        case loaded(main: [Restaurant], favourite: [Restaurant], nextToYou: [Restaurant])
        case error(message: String)
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Restaurant>
    private lazy var datasource = makeDataSource()
    
    weak var delegate: HomeViewControllerDelegate?
    var status: State = .idle {
        didSet {
            switch status {
            case .idle: break
            case .loading:
                loadingView.isHidden = false
                errorView.isHidden = true
            case .loaded(let main, let favourite, let nextToYou):
                loadingView.isHidden = true
                errorView.isHidden = true
                createSnapshot(withMain: main, favourite: favourite, nextToYou: nextToYou)
            case .error(let message):
                loadingView.isHidden = true
                errorView.isHidden = false
                errorView.setError(message)
            }
        }
    }
    
    lazy var myCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collection.backgroundColor = .systemBackground
        collection.register(HomeCollectionViewCell.self)
        collection.register(HeaderView.self, forSupplementaryViewOfKind: HeaderView.kind, withReuseIdentifier: HeaderView.reuseIdentifier)
        collection.delegate = self
        return collection
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.isHidden = true
        return view
    }()
    
    lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        view.onTapAction = { [weak self] in
            self?.delegate?.userDidTapOnRetryButton()
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myCollectionView.pin(to: view)
        loadingView.pin(to: view)
        errorView.pin(to: view)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
       
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
           
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .main, .nextToYou:
                return self.fullItemLayout
            case .favourite:
                return self.squareItemLayout
            }
          }
          return layout
    }
    
    var fullItemLayout: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.80),
                                               heightDimension: .absolute(200))
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
            elementKind: HeaderView.kind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    var squareItemLayout: NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(186),
            heightDimension: .absolute(200))
        
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
            elementKind: HeaderView.kind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func makeDataSource() -> DataSource {
        
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
    
    func createSnapshot(withMain main: [Restaurant], favourite: [Restaurant], nextToYou: [Restaurant]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(main, toSection: .main)
        snapshot.appendItems(favourite, toSection: .favourite)
        snapshot.appendItems(nextToYou, toSection: .nextToYou)
        
        datasource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeViewController {
    
    enum Section: CaseIterable {
        case main
        case favourite
        case nextToYou
        
        var header: String {
            switch self {
            case .main:
                return "home.headers.sections.main".localized
            case .favourite:
                return "home.headers.sections.favourite".localized
            case .nextToYou:
                return "home.headers.sections.nextToYou".localized
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedRestaurant = datasource.itemIdentifier(for: indexPath) else { return }
        delegate?.userDidTapOnRestaurant(selectedRestaurant)
        
    }
}
