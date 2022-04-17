//
//  ArticleStore.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

final class ArticleStore: ObservableObject, Decodable {
    @Published var articles: [Article] = []
    @Published var articlesDev: [Article] = []
    @Published var loading = false
    @Published var links: Links?
    @Published var meta: Meta?
    
    init() {
        fetchContents()
    }
    
    init(on dev: Bool) {
        #if DEBUG
        createDevData()
        #endif
    }
    
    let baseURLString = "https://api.raywenderlich.com/api/contents"
    var baseParameter = [
        "filter[subscription_types][]": "free",
        "filter[content_types][]": "article",
        "filter[domain_ids][]":"1",
        "sort": "-popularity",
        "page[number]": "1",
        "page[size]": "10",
        "filter[q]": ""
    ]
    
    func fetchContents() {
        guard var urlComponents = URLComponents(string: baseURLString) else { return }
        urlComponents.setQueryItems(with: baseParameter)
        guard let url = urlComponents.url else { return }
        print(url)
        
        loading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                defer {
                    DispatchQueue.main.async {
                        self.loading = false
                    }
                }
                print(response.statusCode)
                if let decodedResponse = try? JSONDecoder().decode(
                    ArticleStore.self, from: data) {
                    DispatchQueue.main.async {
                        self.articles = decodedResponse.articles
                        self.links = decodedResponse.links
                        self.meta = decodedResponse.meta
                    }
                    return
                }
            }
            print("Contents fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
    
    func fetchContents(_ str: String) {
        guard !str.isEmpty, let url = URL(string: str) else { return }
        loading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                defer {
                    DispatchQueue.main.async {
                        self.loading = false
                    }
                }
                print(response.statusCode)
                if let decodedResponse = try? JSONDecoder().decode(
                    ArticleStore.self, from: data) {
                    DispatchQueue.main.async {
                        self.articles = decodedResponse.articles
                        self.links = decodedResponse.links
                        self.meta = decodedResponse.meta
                    }
                    return
                }
            }
            print("Contents fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
    
    enum CodingKeys: String, CodingKey {
        case articles = "data"
        case links
        case meta
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        articles = try container.decode([Article].self, forKey: .articles)
        links = try container.decode(Links.self, forKey: .links)
        meta = try container.decode(Meta.self, forKey: .meta)
    }
}

struct Links: Decodable {
    let first: String
    let prev: String?
    let next: String?
    let last: String
}

struct Meta: Decodable {
    var totalResultCount: Int
    
    enum MetaKeys: String, CodingKey {
        case totalResultCount = "total_result_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MetaKeys.self)
        totalResultCount = try container.decode(Int.self, forKey: .totalResultCount)
    }
}
