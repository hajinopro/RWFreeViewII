//
//  ArticleStoreDevData.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

extension ArticleStore {
    func createDevData() {
        articlesDev = [
            Article(id: "2888", uri: "rw://koenig/post/14865", name: "Introduction to Pixel Art for Games", description: "This is a guest post by Glauber Kotaki, an experienced 2D game artist available for hire. Pixel Art is really popular in games these days, and for some great reasons: Looks. Pixel art looks awesome! There’s something to be said about making the most about each pixel in a sprite. Nostalgia. Pixel art brings back […]\n", released: "2012-07-18T15:00:22.000Z", difficulty: "intermediate", urlComponents: nil),
            Article(id: "8549", uri: "rw://koenig/post/205365", name: "Self-sizing Table View Cells", description: "In this tutorial, you’ll learn how to enable self-sizing table view cells, as well as how to make them resize on-demand and support Dynamic Type.\n", released: "2018-11-21T13:59:17.000Z", difficulty: "beginner", urlComponents: nil)
        ]
    }
}
