//
//  HeroListViewControllerTests.swift
//  Marvel HeroesTests
//
//  Created by Andreas Velounias on 23/03/2021.
//

import XCTest

@testable import Marvel_Heroes
@testable import Kingfisher

class HeroListViewControllerTests: XCTestCase {
    
    private var rootWindow: UIWindow!
    private var heroesViewController: HeroesViewController!
    private var mockHeroViewModel: HeroViewModel!
    private var mockNetworkService: NetworkProtocol!
    
    override func setUp() {
        super.setUp()
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mockHeroViewModel = HeroViewModel()
        mockNetworkService = MockNetworkService()
        mockHeroViewModel.networkService = mockNetworkService
        heroesViewController = storyboard.instantiateViewController(withIdentifier: "heroesvc") as? HeroesViewController
        heroesViewController.heroes = mockHeroViewModel
        rootWindow.rootViewController = heroesViewController
        XCTAssertNotNil(heroesViewController.view)
    }
    
    override func tearDown() {
        super.tearDown()
        rootWindow = nil
        heroesViewController = nil
        mockHeroViewModel = nil
        mockNetworkService = nil
    }
    
    func testCollectionView() {
        XCTAssertNotNil(heroesViewController.collectionView)
        XCTAssertNotNil(heroesViewController.collectionView.delegate)
        XCTAssertNotNil(heroesViewController.collectionView.dataSource)
        XCTAssertTrue(heroesViewController.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(heroesViewController.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(heroesViewController.responds(to: #selector(heroesViewController!.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(heroesViewController.responds(to: #selector(heroesViewController!.collectionView(_:cellForItemAt:))))
        XCTAssertTrue(heroesViewController.responds(to: #selector(heroesViewController!.collectionView(_:didSelectItemAt:))))
    }
    
    func testFetchHeroes() {
        XCTAssertTrue(heroesViewController.isLoadingList)
        XCTAssertEqual(heroesViewController.collectionView.numberOfItems(inSection: 0), 0)
        XCTAssertEqual(heroesViewController.currentPage, 0)
        heroesViewController.fetchHeroes(page: heroesViewController.currentPage)
        XCTAssertEqual(heroesViewController.collectionView.numberOfItems(inSection: 0), 0)
        XCTAssertEqual(heroesViewController.currentPage, 0)
        XCTAssertTrue(heroesViewController.isLoadingList)
    }
}
