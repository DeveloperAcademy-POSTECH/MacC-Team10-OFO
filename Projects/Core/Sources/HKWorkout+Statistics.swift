/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An extension that provides formatted strings for workout metrics.
*/

import Foundation
import HealthKit

// MARK: - Workout statistics
//
extension HKWorkout {
    public var totalTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? ""
    }

    public var totalDistance: Double {
        var value: Double = 0
        if let statistics = statistics(for: HKQuantityType(.distanceWalkingRunning)),
           let sum = statistics.sumQuantity() {
            value = sum.doubleValue(for: .meter())
        }
        return value
    }

    public var totalEnergy: Double {
        var value: Double = 0
        if let statistics = statistics(for: HKQuantityType(.activeEnergyBurned)),
           let sum = statistics.sumQuantity() {
            value = sum.doubleValue(for: .kilocalorie())
        }
        return value
    }

    public var averageHeartRate: String {
        var value: Double = 0
        if let statistics = statistics(for: HKQuantityType(.heartRate)),
           let average = statistics.averageQuantity() {
            let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
            value = average.doubleValue(for: heartRateUnit)
        }
        return value.formatted(.number.precision(.fractionLength(0))) + " bpm"
    }
}
