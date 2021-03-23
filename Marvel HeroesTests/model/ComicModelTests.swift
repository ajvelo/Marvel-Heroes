//
//  ComicModelTests.swift
//  Marvel HeroesTests
//
//  Created by Andreas Velounias on 23/03/2021.
//

import XCTest

@testable import Marvel_Heroes

class ComicModelTests: XCTestCase {
    
    func testInitializeAndEquatable() {
        let spidermanComic = ComicModel(id: 0, title: "test", thumbnail: ThumbnailModel(path: "", ext: ""))
        XCTAssertEqual(spidermanComic.id, 0)
        XCTAssertEqual(spidermanComic.title, "test")
        XCTAssertEqual(spidermanComic.thumbnail, ThumbnailModel(path: "", ext: ""))
        let spidermanTwoComic = ComicModel(id: 0, title: "test", thumbnail: ThumbnailModel(path: "", ext: ""))
        XCTAssertEqual(spidermanTwoComic.id, 0)
        XCTAssertEqual(spidermanTwoComic.title, "test")
        XCTAssertEqual(spidermanTwoComic.thumbnail, ThumbnailModel(path: "", ext: ""))
        XCTAssert(spidermanComic == spidermanTwoComic)
    }
}
