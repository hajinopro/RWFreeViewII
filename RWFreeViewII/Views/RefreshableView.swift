//
//  RefreshableView.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

struct RefreshableView: View {
    @Environment(\.refresh) private var refresh

    var body: some View {
        Button("Refresh") {
            Task {
                await refresh?()
            }
        }
        .disabled(refresh == nil)
    }
}

struct RefreshableView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableView()
    }
}
