//
//  SwiftUIView.swift
//  Feature
//
//  Created by 한지석 on 10/22/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import SwiftData
import Core

public struct SwiftUIView: View {

    public init() {}

    public var body: some View {
        TabView {
            MainView(modelContext: playerContainer.mainContext)
                .tabItem {
                    Label("기록", systemImage: "rectangle.stack.person.crop").tint(.white)
                }
                .modelContainer(playerContainer)
            RecordView(observable: RecordObservableObject())
                .tabItem {
                    Label("갤러리", systemImage: "flame.fill").accentColor(.white)
                }
        }
        .accentColor(.white)
        .environment(\.colorScheme, .dark)
    }
}
