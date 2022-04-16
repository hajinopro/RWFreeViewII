//
//  ArticleButtonView.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

struct ArticleButtonView: View {
    let width: CGFloat
    let height: CGFloat
    let radius: CGFloat
    let gradientColors = Gradient(colors: [Color("gradient-dark"), Color("gradient-light")])
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .fill(LinearGradient(gradient: gradientColors, startPoint: .leading, endPoint: .trailing))
                .frame(width: width, height: height)
            Image(systemName: "seal.fill")
                .font(.title)
                .colorInvert()
            Text("H")
                .fontWeight(.heavy)
        }
    }
}

struct ArticleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleButtonView(width: 50, height: 50, radius: 0)
            //.previewLayout(.sizeThatFits)
    }
}
