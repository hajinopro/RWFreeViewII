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
                    self.loading = false
                }
                print(response.statusCode)
                if let decodedResponse = try? JSONDecoder().decode(  // 1
                    ArticleStore.self, from: data) {
                    DispatchQueue.main.async {
                        self.articles = decodedResponse.articles  // 2
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
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        articles = try container.decode([Article].self, forKey: .articles)
    }
}
