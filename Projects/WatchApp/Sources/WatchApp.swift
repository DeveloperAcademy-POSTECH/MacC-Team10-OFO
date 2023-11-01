//
//  WatchApp.swift
//  WatchApp
//
//  Created by Ha Jong Myeong on 10/28/23.
//

import SwiftUI

@main
struct WatchApp: App {
    @StateObject var workoutManager = WorkoutManager()

    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                StartView()
            })
            .sheet(isPresented: $workoutManager.showingSummaryView, content: {
                SummaryView()
            })
            .environmentObject(workoutManager)
        }
    }
}
