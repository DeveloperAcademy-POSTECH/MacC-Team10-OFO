//
//  WorkoutManager.swift
//  Core
//
//  Created by 박승찬 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import HealthKit
import os

public class WorkoutManager: NSObject, ObservableObject {
    public static let shared = WorkoutManager()

    public let typesToShare: Set = [HKQuantityType.workoutType(),
                             HKQuantityType(.dietaryWater)]
    public let typesToRead: Set = [
        HKQuantityType(.heartRate),
        HKQuantityType(.activeEnergyBurned),
        HKQuantityType(.distanceWalkingRunning),
        HKQuantityType(.dietaryWater),
        HKQuantityType.workoutType(),
        HKObjectType.activitySummaryType()
    ]
    public let healthStore = HKHealthStore()
}

// MARK: - Fetching workouts and workout quantity collections.
//
extension WorkoutManager {
    public func fetchTodaysWorkouts(workoutType: HKWorkoutActivityType) async -> [HKWorkout] {
        let samples = try? await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKSample], Error>) in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: .now)

            guard let startDate = calendar.date(from: components),
                  let endDate = calendar.date(byAdding: .day, value: 1, to: startDate) else {
                Logger.shared.log("Failed to create dates from: \(components)")
                continuation.resume(returning: [])
                return
            }

            let todayPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])

            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [todayPredicate])

            let sortByStartDate = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)

            let query = HKSampleQuery(sampleType: .workoutType(),
                                      predicate: .none, //여기가 언제부터 언제까지 시간에 따른 predicate 이거 바꿔주면 전체 데이터로 가능
//                                      predicate: compoundPredicate,
                                      limit: HKObjectQueryNoLimit,
                                      sortDescriptors: [sortByStartDate]) { (query, samples, error) in
                if let error {
                    Logger.shared.log("Failed to run a sample query: \(error)")
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: samples!)
            }
            healthStore.execute(query)
        }
        let workouts = samples as? [HKWorkout]
        return workouts == nil ? [] : workouts!
    }

    func fetchQuantityCollection(for workout: HKWorkout,
                                 quantityTypeIdentifier: HKQuantityTypeIdentifier,
                                 statisticsOptions: HKStatisticsOptions) async -> [HKStatistics] {
        let results = try? await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKStatistics], Error>) in
            let calendar = Calendar.current
            let interval = DateComponents(minute: 1)
            let components = DateComponents(calendar: calendar, timeZone: calendar.timeZone, second: 59)

            guard let anchorDate = calendar.nextDate(after: Date(),
                                                     matching: components,
                                                     matchingPolicy: .nextTime,
                                                     repeatedTimePolicy: .first,
                                                     direction: .backward) else {
                Logger.shared.log("Failed to calculate the anchor date.")
                continuation.resume(returning: [])
                return
            }

            let predicateForWorkout = HKQuery.predicateForObjects(from: workout)
            let quantityType = HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!
            let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                    quantitySamplePredicate: predicateForWorkout,
                                                    options: statisticsOptions,
                                                    anchorDate: anchorDate,
                                                    intervalComponents: interval)

            query.initialResultsHandler = { (query, results, error) in
                if let error = error {
                    Logger.shared.log("Failed to run a statistics collection query: \(error)")
                    continuation.resume(throwing: error)
                    return
                }

                var collection = [HKStatistics]()
                results?.enumerateStatistics(from: workout.startDate, to: workout.endDate) { (statistics, stop) in
                    collection.append(statistics)
                }
                continuation.resume(returning: collection)
            }
            healthStore.execute(query)
        }
        return results ?? []
    }
}

