//
//  ComicViewControllerTests.swift
//  Marvel HeroesTests
//
//  Created by Andreas Velounias on 23/03/2021.
//

import XCTest

@testable import Marvel_Heroes
@testable import Kingfisher

class ComicViewControllerTests: XCTestCase {
    
    private var rootWindow: UIWindow!
    private var comicViewController: ComicViewController!
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
        comicViewController = storyboard.instantiateViewController(withIdentifier: "comicsvc") as? ComicViewController
        comicViewController.heroes = mockHeroViewModel
        comicViewController.selectedHero = mockHeroViewModel.selectedHero
        rootWindow.rootViewController = comicViewController
        XCTAssertNotNil(comicViewController.view)
    }
    
    override func tearDown() {
        super.tearDown()
        rootWindow = nil
        comicViewController = nil
        mockHeroViewModel = nil
        mockNetworkService = nil
    }
    
    func testCollectionView() {
        XCTAssertNotNil(comicViewController.collectionView.delegate)
        XCTAssertNotNil(comicViewController.collectionView.dataSource)
        XCTAssertTrue(comicViewController.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(comicViewController.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(comicViewController.responds(to: #selector(comicViewController!.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(comicViewController.responds(to: #selector(comicViewController!.collectionView(_:cellForItemAt:))))
    }
    
    func testLoadComics() {
        XCTAssertFalse(comicViewController.isLoadingList)
        XCTAssertEqual(comicViewController.collectionView.numberOfItems(inSection: 0), comicViewController.heroes?.heroes.count)
        XCTAssertEqual(comicViewController.currentPage, 0)
        comicViewController.fetchComicsForHero(page: comicViewController.currentPage, heroId: comicViewController.selectedHero!.id)
        XCTAssertFalse(comicViewController.isLoadingList)
    }
}
