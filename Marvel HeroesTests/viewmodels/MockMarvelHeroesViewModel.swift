//
//  MockMarvelHeroesViewModel.swift
//  Marvel HeroesTests
//
//  Created by Andreas Velounias on 22/03/2021.
//

import Foundation

@testable import Marvel_Heroes

class MockMarvelHeroesViewModel: HeroViewModelProtocol {
    var selectedHero: HeroModel = HeroModel(id: 0, name: "Spider-Man", thumbnail: ThumbnailModel(path: "", ext: ""), description: "test description")
    
    func getHeroes(page: Int, complete: @escaping (ServiceResult<[HeroModel]?>) -> Void) {
        return complete(.Success((self.heroes), 0))
    }
    
    var heroes: [HeroModel] = []
    
    func getHeroComics(page: Int, heroId: Int, complete: @escaping (ServiceResult<[ComicModel]?>) -> Void) {
        return complete(.Success((self.comicList), 0))
    }
    
    var comicList: [ComicModel] = []
    
    
}
