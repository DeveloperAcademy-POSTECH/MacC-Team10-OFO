//
//  WatchApp.swift
//  WatchApp
//
//  Created by Ha Jong Myeong on 10/28/23.
//

import SwiftUI

@main
struct WatchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentsView()
                .environment(\.colorScheme, .dark)
        }
    }
}
