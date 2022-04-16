//
//  RWFreeViewIIApp.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

@main
struct RWFreeViewIIApp: App {
    @StateObject private var store = ArticleStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
