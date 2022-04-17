//
//  HeaderView.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

struct HeaderView: View {
    let count: Int
    var totalCount: Int
    @State private var sortOn = "none"
    @EnvironmentObject var store: ArticleStore
    
    var body: some View {
        HStack {
            Text("\(count) / \(totalCount) Article(s)")
                .foregroundColor(Color(UIColor.systemGray))
            Menu("\(Image(systemName: "filemenu.and.cursorarrow"))") {
                Button("5 results/page") {
                    store.baseParameter["page[size]"] = "5"
                    store.fetchContents()
                }
                Button("10 results/page") {
                    store.baseParameter["page[size]"] = "10"
                    store.fetchContents()
                }
                Button("20 results/page") {
                    store.baseParameter["page[size]"] = "20"
                    store.fetchContents()
                }
                Button("No change") { }
            }
            .tint(Color(UIColor.systemGray))
            Spacer()
            Picker("", selection: $sortOn) {
                Text("New").tag("new")
                Text("Popular").tag("popular")
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 120)
            .onChange(of: sortOn) { newValue in
                store.baseParameter["sort"] = sortOn == "new" ? "-released_at" : "-popularity"
                store.fetchContents()
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(count: 10, totalCount: 20)
            .environmentObject(ArticleStore())
            .previewLayout(.sizeThatFits)
    }
}
