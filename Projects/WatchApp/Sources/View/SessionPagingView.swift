//
//  SessioniPagingView.swift
//  WatchApp
//
//  Created by 박승찬 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI

struct SessionPagingView: View {
    @State private var selection: Tab = .metrics

    enum Tab {
        case controls, metrics
    }
    var body: some View {
        TabView(selection: $selection,
                content:  {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SessionPagingView()
}
