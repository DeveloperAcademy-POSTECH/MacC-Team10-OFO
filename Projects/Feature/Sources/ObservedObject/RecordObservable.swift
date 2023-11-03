//
//  RecordObservableObject.swift
//  Feature
//
//  Created by 박승찬 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import SwiftData
import Core
import HealthKit

@Observable
class RecordObservable {

    private let workoutManager = WorkoutManager.shared

    var workoutList: [HKWorkout]?

    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager<Record>
    var modelContext: ModelContext
    var record: [Record]?
    var calories: Double = 0

    @MainActor
    init(modelContext: ModelContext) {
        self.swiftDataManager = SwiftDataManager<Record>(modelContext: modelContext)
        self.modelContext = modelContext
        self.record = record
        Task {
            self.workoutList = await workoutManager.fetchTodaysWorkouts(workoutType: .soccer)
        }
    }

    func updateCalories() {
        calories = self.workoutList![0].totalEnergy
        insertTempRecord(record: Record(totalPlay: Int.random(in: 1..<100),
                                        totalPlayTime: Date(),
                                        totalCalories: calories,
                                        totalDistanceCovered: 0))
    }

    func insertTempRecord(record: Record) {
        swiftDataManager.insertItem(item: record)
        let _ = fetchRecord()
    }

    func fetchRecord() -> [Record]? {
        if let record: [Record] = swiftDataManager.fetchItem() {
            for index in 0..<record.count {
                print("@Log Calories \(index) - \(record[index].totalCalories)")
            }
            return record
        } else {
            return nil
        }
    }

}

//    class RecordObservableObject: RecordDetailDelegate, ObservableObject {
//        @Published var records: [Record]
//
//        init() {
//            self.records = []
//        }
//
//        func setRecord(record: Core.Record, index: Int) {
//            records[index] = record
//        }
//    }
