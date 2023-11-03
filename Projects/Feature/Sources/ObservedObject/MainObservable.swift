//
//  MainObservableObject.swift
//  Feature
//
//  Created by 한지석 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Core
import SwiftData
import SwiftUI

@Observable class MainObservable {

    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager<Player>
    var modelContext: ModelContext
    var player: Player?

    @MainActor
    init(modelContext: ModelContext) {
        self.swiftDataManager = SwiftDataManager<Player>(modelContext: modelContext)
        self.modelContext = modelContext
        self.player = fetchPlayer()
    }

    func updatePlayer(player: Player) {
        self.player?.height = player.height
    }

    ///func fetchPlayer: 플레이어 정보를 패치합니다.
    ///return: [Player].first
    func fetchPlayer() -> Player? {
        if let player: [Player] = swiftDataManager.fetchItem() {
            return player.first
        } else {
            return nil
        }
    }
}
