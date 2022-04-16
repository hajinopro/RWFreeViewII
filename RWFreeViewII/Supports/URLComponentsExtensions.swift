//
//  URLComponentsExtensions.swift
//  RWFreeViewII
//
//  Created by 하진호 on 2022/04/16.
//

import SwiftUI

extension URLComponents {
    mutating func setQueryItems(with parameter: [String: String]) {
        self.queryItems = parameter.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
