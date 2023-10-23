//
//  RecordObservedObject.swift
//  Feature
//
//  Created by 박승찬 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import Core

class RecordObservedObject: ObservableObject {
    @Published var records: [[Record]]

    init(records: [[Record]]) {
        self.records = records
    }

}
