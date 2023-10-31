//
//  ContentsView.swift
//  WatchApp
//
//  Created by Ha Jong Myeong on 10/28/23.
//

import SwiftUI

public struct ContentsView: View {

    public init() {}

    public var body: some View {
        VStack {
            Text("Hello, SwiftUI!")
        }
        .accentColor(.white)
        .environment(\.colorScheme, .dark)
    }
}
