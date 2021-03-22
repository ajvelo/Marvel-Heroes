//
//  ComicModel.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import Foundation

class ComicModel: Decodable {
    let id: Int
    let title: String
    let thumbnail: ThumbnailModel
    
    init(id: Int, title: String, thumbnail: ThumbnailModel) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
}

extension ComicModel: Equatable {
    static func == (lhs: ComicModel, rhs: ComicModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.thumbnail == rhs.thumbnail
    }
}

class ComicData: Decodable {
    let results: [ComicModel]
}

class ComicResponse: Decodable {
    let data: ComicData
}
