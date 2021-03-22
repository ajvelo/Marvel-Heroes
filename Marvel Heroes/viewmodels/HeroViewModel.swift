//
//  HeroViewModel.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import Foundation

protocol HeroViewModelProtocol {
    
    func getHeroes(
        page: Int,
        complete: @escaping ( ServiceResult<[HeroModel]?> ) -> Void )
    
    var heroes: [HeroModel] { get }
    
    var selectedHero: HeroModel {get}

    func getHeroComics(
        page: Int,
        heroId: Int,
        complete: @escaping ( ServiceResult<[ComicModel]?> ) -> Void )

    var comicList: [ComicModel] { get }
    
}

class HeroViewModel: HeroViewModelProtocol {
    
    var networkService: NetworkProtocol?

    init() {}
    
    private let pageSize = 20
    
    private var heroList = [HeroModel]()
    var heroes: [HeroModel] {
        get { return heroList }
        set { heroList = newValue }
    }
    
    private var currentHero = HeroModel(id: 0, name: "", thumbnail: ThumbnailModel(path: "", ext: ""), description: "")
    var selectedHero: HeroModel {
        get { return currentHero }
        set { currentHero = newValue}
    }

    internal var comicList = [ComicModel]()
    var comics: [ComicModel] {
        get { return comicList }
        set { comicList = newValue }
    }

    func getHeroes(
        page: Int,
        complete: @escaping ( ServiceResult<[HeroModel]?> ) -> Void )  {
        let offset = page * pageSize
        guard let networkService = networkService else {
            return complete(.Error("Missing network service", 0))
        }
        let baseUrl = networkService.baseUrl
        let hash = networkService.authPath
        let url = "\(baseUrl)characters?\(hash)&offset=\(offset)"
//        let url = "\(baseUrl)characters?\(hash)&offset=\(offset)&nameStartsWith=spider"
        networkService.request(
            url: url,
            method: .get,
            parameters: nil
        ) { [weak self] (result) in
            if page == 0 {
                self?.heroList.removeAll()
            }
            switch result {
            case .Success(let json, let statusCode):
                do {
                    if let data = json?.data(using: .utf8) {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(HeroResponse.self, from: data)
                        self?.heroList.append(contentsOf: response.data.results)
                        return complete(.Success(self?.heroList, statusCode))
                    }
                    return complete(.Error("Error parsing data", statusCode))
                } catch {
                    print("error:\(error)")
                    return complete(.Error("Error decoding JSON", statusCode))
                }
            case .Error(let message, let statusCode):
                return complete(.Error(message, statusCode))
            }
        }
    }
    
    func getHeroComics(
        page: Int,
        heroId: Int,
        complete: @escaping ( ServiceResult<[ComicModel]?> ) -> Void )  {
        let offset = page * pageSize
        guard let networkService = networkService else {
            return complete(.Error("Missing network service", 0))
        }
        let baseUrl = networkService.baseUrl
        let hash = networkService.authPath
        let url = "\(baseUrl)characters/\(heroId)/comics?\(hash)&offset=\(offset)"
        networkService.request(
            url: url,
            method: .get,
            parameters: nil
        ) { [weak self] (result) in
            if page == 0 {
                self?.comicList.removeAll()
            }
            switch result {
            case .Success(let json, let statusCode):
                do {
                    if let data = json?.data(using: .utf8) {
                        let decoder = JSONDecoder()
                        let comicResponse = try decoder.decode(ComicResponse.self, from: data)
                        self?.comicList.append(contentsOf: comicResponse.data.results)
                        return complete(.Success(self?.comicList, statusCode))
                    }
                    return complete(.Error("Error parsing data", statusCode))
                } catch {
                    print("error:\(error)")
                    return complete(.Error("Error decoding JSON", statusCode))
                }
            case .Error(let message, let statusCode):
                return complete(.Error(message, statusCode))
            }
        }
    }
    
}

