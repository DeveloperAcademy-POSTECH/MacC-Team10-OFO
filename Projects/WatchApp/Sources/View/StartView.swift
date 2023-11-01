//
//  StartView.swift
//  WatchApp
//
//  Created by 박승찬 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI

struct StartView: View {
    @State private var didStartWorkout = false
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    didStartWorkout = true
                    // 풋살 기록 시작
                } label: {
                    Image(systemName: "play.fill")
                }
                .tint(Color.green)
                .font(.title2)
                Text("Play")
            }
            .navigationDestination(isPresented: $didStartWorkout) {
                SessionPagingView()
            }
        }
    }
}

#Preview {
    StartView()
}
