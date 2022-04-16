//
//  ArticleWebView.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

struct ArticleWebView: View {
    let article: Article
    let baseURL: String = "https://www.raywenderlich.com/"
    
    var body: some View {
        VStack {
            if let urlString = baseURL + article.id + "-" + changeName(article.name) {
                MyWebView(urlToLoad: urlString)
            } else {
                EmptyView()
            }
        }
        .navigationTitle(article.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func changeName(_ name: String) -> String {
        var newName = ""
        name.forEach {
            if $0 == " " {
                newName += "%20"
            } else {
                newName += String($0)
            }
        }
        return newName
    }
}

struct ArticleWebView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleWebView(article: ArticleStore(on: true).articlesDev[0])
        }
    }
}
