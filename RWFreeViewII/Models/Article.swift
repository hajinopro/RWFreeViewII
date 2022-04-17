//
//  Article.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

struct Article: Decodable, Identifiable {
    let id: String
    
    let uri: String
    let name: String
    let description: String
    let released: String
    let difficulty: String?
    let urlComponents: URLComponents?
    
    enum DataKeys: CodingKey {
        case id, attributes
    }
    
    enum AttrKeys: String, CodingKey {
        case uri, name, description
        case releasedAt = "released_at"
        case difficulty
    }
}

extension Article {
    init(from decoder: Decoder) throws {
        let dataContainer = try decoder.container(keyedBy: DataKeys.self)
        id = try dataContainer.decode(String.self, forKey: .id)
        let attr = try dataContainer.nestedContainer(keyedBy: AttrKeys.self, forKey: .attributes)
        uri = try attr.decode(String.self, forKey: .uri)
        name = try attr.decode(String.self, forKey: .name)
        description = try attr.decode(String.self, forKey: .description)
        let releasedAt = try attr.decode(String.self, forKey: .releasedAt)
        let releaseDate = DateFormatter.iso8601.date(from: releasedAt)
        released = DateFormatter.articleDateFormatter.string(from: releaseDate!)
        difficulty = try attr.decode(String?.self, forKey: .difficulty)
        urlComponents = URLComponents(string: name) ?? nil
    }
}
