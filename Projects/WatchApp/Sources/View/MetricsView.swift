//
//  MetricsView.swift
//  WatchApp
//
//  Created by 박승찬 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager

    var body: some View {
        TimelineView(MetricsTimelineSchedule(
            from: workoutManager.builder?.startDate ?? Date(),
            isPaused: workoutManager.session?.state == .paused)) { context in
            VStack(alignment: .leading) {
                ElapsedTimeView(elapsedTime: workoutManager.builder?.elapsedTime(at: context.date) ?? 0,
                                showSubseconds: context.cadence == .live)
                    .foregroundStyle(.yellow)
                Text(Measurement(value: workoutManager.activeEnergy,
                                 unit: UnitEnergy.kilocalories)
                        .formatted(.measurement(width: .abbreviated,
                                                usage: .workout,
                                                numberFormatStyle: .number.precision(.fractionLength(0)))))
                Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                Text(Measurement(value: workoutManager.distance,
                                 unit: UnitLength.meters).formatted(.measurement(width: .abbreviated, usage: .road)))
            }
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
        }
    }
}

#Preview {
    MetricsView()
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    var isPaused: Bool

    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }

    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate,
                                                    by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)

        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}
