//
//  HeroModelTests.swift
//  Marvel HeroesTests
//
//  Created by Andreas Velounias on 23/03/2021.
//

import XCTest

@testable import Marvel_Heroes

class HeroModelTests: XCTestCase {
    
    func testInitializeAndEquatable() {
        let spiderman = HeroModel(id: 0, name: "Spider-Man", thumbnail: ThumbnailModel(path: "", ext: ""), description: "test")
        XCTAssertEqual(spiderman.id, 0)
        XCTAssertEqual(spiderman.name, "Spider-Man")
        XCTAssertEqual(spiderman.thumbnail, ThumbnailModel(path: "", ext: ""))
        XCTAssertEqual(spiderman.description, "test")
        let spidermanTwo = HeroModel(id: 0, name: "Spider-Man", thumbnail: ThumbnailModel(path: "", ext: ""), description: "test")
        XCTAssertEqual(spidermanTwo.id, 0)
        XCTAssertEqual(spidermanTwo.name, "Spider-Man")
        XCTAssertEqual(spidermanTwo.thumbnail, ThumbnailModel(path: "", ext: ""))
        XCTAssertEqual(spidermanTwo.description, "test")
        XCTAssert(spiderman == spidermanTwo)
    }
}
