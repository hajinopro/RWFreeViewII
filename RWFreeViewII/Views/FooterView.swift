//
//  FooterView.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/17.
//

import SwiftUI

struct FooterView: View {
    @EnvironmentObject var store: ArticleStore
    
    var body: some View {
        HStack(spacing: 30) {
            Spacer()
            Button(action: { store.fetchContents(store.links?.first ?? "") }) {
                Image(systemName: "backward.end")
            }
            Button(action: { store.fetchContents(store.links?.prev ?? "") }) {
                Image(systemName: "arrowtriangle.backward")
            }
            Button(action: { store.fetchContents(store.links?.next ?? "") }) {
                Image(systemName: "arrowtriangle.forward")
            }
            Button(action: { store.fetchContents(store.links?.last ?? "") }) {
                Image(systemName: "forward.end")
            }
            Spacer()
        }
        .font(.title)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
            .environmentObject(ArticleStore())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
