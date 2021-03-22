//
//  HeroModel.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

class HeroData: Decodable {
    let results: [HeroModel]
}

class HeroResponse: Decodable {
    let data: HeroData
}

class HeroModel: Decodable {
    let id: Int
    let name: String
    let thumbnail: ThumbnailModel
    let description: String
    
    init(id: Int, name: String, thumbnail: ThumbnailModel, description: String) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
    }
}

class ThumbnailModel: Decodable {
    let path: String
    let extend: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case extend = "extension"
    }
    
    init(path: String, ext: String) {
        self.path = path
        self.extend = ext
    }
    
    required init(from decoder: Decoder) throws {
        let allValues = try decoder.container(keyedBy: CodingKeys.self)
        path = try allValues.decode(String.self, forKey: .path)
        extend = try allValues.decode(String.self, forKey: .extend)
    }
    
    var fullName: String {
        get { return path + "." + extend }
    }

}

extension ThumbnailModel: Equatable {
    static func == (lhs: ThumbnailModel, rhs: ThumbnailModel) -> Bool {
        return lhs.path == rhs.path &&
            lhs.extend == rhs.extend
    }
}

extension HeroModel: Equatable {
    static func == (lhs: HeroModel, rhs: HeroModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.thumbnail == rhs.thumbnail &&
               lhs.description == rhs.description
    }
}
