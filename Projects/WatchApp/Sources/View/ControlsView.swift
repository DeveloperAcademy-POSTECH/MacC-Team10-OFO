//
//  ControlsView.swift
//  WatchApp
//
//  Created by 박승찬 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            VStack {
                Button {
                    workoutManager.endWorkout() // 풋살 끝 버튼
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(Color.red)
                .font(.title2)
                Text("End")
            }
            VStack {
                Button {
                    workoutManager.togglePause() // 풋살 멈춤 버튼
                } label: {
                    Image(systemName: workoutManager.running ? "pause" : "play")
                }
                .tint(Color.yellow)
                .font(.title2)
                Text(workoutManager.running ? "Pause" : "Resume")
            }
        }
    }
}

#Preview {
    ControlsView()
}
