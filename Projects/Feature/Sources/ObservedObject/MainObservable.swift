//
//  MainObservableObject.swift
//  Feature
//
//  Created by 한지석 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import SwiftData
import Core

@Observable class MainObservable {

    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager<Player>
    var modelContext: ModelContext
    var player: Player?

    @MainActor
    init(modelContext: ModelContext) {
        self.swiftDataManager = SwiftDataManager<Player>(modelContext: modelContext)
        self.modelContext = modelContext
        self.player = fetchPlayerInfo()
    }

    func updatePlayerInfo(player: Player) {
        self.player?.height = player.height
    }

    func fetchPlayerInfo() -> Player? {
        if let players: [Player] = swiftDataManager.fetchItem() {
            for index in 0..<players.count {
                print(players[index].height)
            }
            return players.first
        } else {
            return nil
        }
    }
}
