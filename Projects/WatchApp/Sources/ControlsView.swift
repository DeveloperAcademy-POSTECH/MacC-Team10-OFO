//
//  ControlsView.swift
//  WatchApp
//
//  Created by 박승찬 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI

struct ControlsView: View {
    var body: some View {
        HStack {
            VStack {
                Button {
                    // 풋살 끝 버튼
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(Color.red)
                .font(.title2)
                Text("End")
            }
            VStack {
                Button {
                    // 풋살 멈춤 버튼
                } label: {
                    Image(systemName: "pause" )
                }
                .tint(Color.yellow)
                .font(.title2)
                Text("Pause")
            }
        }
    }
}

#Preview {
    ControlsView()
}
