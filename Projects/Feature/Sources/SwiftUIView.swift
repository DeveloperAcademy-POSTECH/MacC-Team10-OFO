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
                    Label("홈", systemImage: "flame.fill")
                }
                .modelContainer(playerContainer)
            RecordView(modelContext: recordContainer.mainContext)
                .tabItem {
                    Label("기록", systemImage: "person.crop.rectangle.stack")
                }
                .background(Color(.systemGroupedBackground))
                .modelContainer(recordContainer)
        }
        .accentColor(.black)
    }
}
