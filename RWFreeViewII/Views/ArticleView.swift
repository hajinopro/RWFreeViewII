//
//  ArticleView.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    
    var body: some View {
        HStack {
            ArticleButtonView(width: 50, height: 50, radius: 10)
                .unredacted()
            VStack(alignment: .leading) {
                Text(article.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                HStack {
                    Text(article.released)
                    Text(article.difficulty ?? "")
                }
                Text(article.description)
                    .lineLimit(2)
            }
            .font(.footnote)
            .foregroundColor(Color(UIColor.systemGray))
            .padding(.horizontal)
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: ArticleStore(on: true).articlesDev[0])
    }
}
