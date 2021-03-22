//
//  HeroViewModelTests.swift
//  Marvel HeroesTests
//
//  Created by Andreas Velounias on 22/03/2021.
//

import XCTest

@testable import Marvel_Heroes

class HeroViewModelTests: XCTestCase {
    
    private var heroViewModel: HeroViewModel!
    private var mockNetworkService: NetworkProtocol!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        heroViewModel = HeroViewModel()
        heroViewModel.networkService = mockNetworkService
        
    }
    
    override func tearDown() {
        super.tearDown()
        heroViewModel = nil
        mockNetworkService = nil
    }
    
    func testAddingHero() {
        let hero = HeroModel(id: 0, name: "Spider-Man", thumbnail: ThumbnailModel(path: "test", ext: "testext"), description: "test description")
        heroViewModel.heroes.append(hero)
        XCTAssertEqual(heroViewModel.heroes.first, hero)
    }
    
    func testGetHeroes() {
        let promise = expectation(description: "testGetHeroes")
        heroViewModel.getHeroes(page: 0) { (result) in
            switch result {
            case .Success(let heroList, _):
                XCTAssertEqual(heroList?.count, 19)
                XCTAssertEqual(heroList?.count, self.heroViewModel.heroes.count)
                let spidergirl = heroList![0]
                XCTAssertEqual(spidergirl.name, "Spider-Girl (Anya Corazon)")
                promise.fulfill()
            case .Error(let message, let statusCode):
                XCTFail("Error: statusCode=\(statusCode ?? -1) \(message)")
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetHeroComics() {
        let promise = expectation(description: "testGetHeroComics")
        let testId = 21171
        heroViewModel.getHeroComics(page: 0, heroId: testId) { (result) in
            switch result {
            case .Success(let comicList, _):
                XCTAssertEqual(comicList?.count, 19)
                XCTAssertEqual(comicList?.count, self.heroViewModel.comicList.count)
                let firstComic = comicList![0]
                XCTAssertEqual(firstComic.title, "Amazing Spider-Man (1999) #558 (Turner Variant)")
                promise.fulfill()
            case .Error(let message, let statusCode):
                XCTFail("Error: statusCode=\(statusCode ?? -1) \(message)")
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
