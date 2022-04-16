//
//  ActivityIndicatorView.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

struct ActivityIndicatorView: View {
    let style = StrokeStyle(lineWidth: 6, lineCap: .round)
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(AngularGradient(gradient: Gradient(colors: [Color("gradient-dark"), Color("gradient-light")]), center: .center), style: style)
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
            .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false), value: animate)
        }
        .onAppear {
            animate.toggle()
        }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
