//
//  ContentView.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: ArticleStore
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    HeaderView(count: store.articles.count, totalCount: store.meta?.totalResultCount ?? 0)
                        .unredacted()
                    ForEach(store.articles) { article in
                        NavigationLink {
                            ArticleWebView(article: article)
                        } label: {
                            ArticleView(article: article)
                        }
                    }
                }
                VStack {
                    Spacer()
                    FooterView()
                        .unredacted()
                }
                .padding(.bottom)
            }
            .refreshable {
                store.fetchContents()
            }
            .redacted(reason: store.loading ? .placeholder : [])
            .searchable(text: $searchText)
            .onChange(of: searchText, perform: { _ in
                store.baseParameter["filter[q]"] = searchText
                store.fetchContents()
            })
            .navigationTitle("Articles")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ArticleStore())
    }
}
