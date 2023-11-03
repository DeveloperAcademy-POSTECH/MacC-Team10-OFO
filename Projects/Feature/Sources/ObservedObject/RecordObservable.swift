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

@Observable
class RecordObservable {

    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager<Record>
    var modelContext: ModelContext
    var record: [Record]?

    @MainActor
    init(modelContext: ModelContext) {
        self.swiftDataManager = SwiftDataManager<Record>(modelContext: modelContext)
        self.modelContext = modelContext
        self.record = record
    }

    func fetchRecord() -> [Record]? {
        if let record: [Record] = swiftDataManager.fetchItem() {
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
