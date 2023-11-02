//
//  SwiftDataManager.swift
//  Core
//
//  Created by 한지석 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import SwiftData

enum SwiftDataError: Error {
    case playerContainerError
    case recordContainerError
    case fetchError

    var description: String {
        switch self {
        case .playerContainerError:
            "@Error - PlayerContainerError"
        case .recordContainerError:
            "@Error - RecordContainerError"
        case .fetchError:
            "@Error - FetchError"
        }
    }
}

@MainActor
public let playerContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Player.self)
        let context = container.mainContext
        if try context.fetch(FetchDescriptor<Player>()).isEmpty {
            container.mainContext.insert(Player(height: 0,
                                                weight: 0,
                                                birth: Date(),
                                                gender: .male,
                                                goal: .init(goalCalories: 0,
                                                            goalDistanceCovered: 0)))
        }
        return container
    } catch {
        fatalError(SwiftDataError.playerContainerError.description)
    }
}()

@MainActor
public let recordContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Record.self)
        return container
    } catch {
        fatalError(SwiftDataError.recordContainerError.description)
    }
}()

public final class SwiftDataManager<T: PersistentModel> {

    private let modelContext: ModelContext

    @MainActor
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func insertItem(item: T) {
        modelContext.insert(item)
    }

    public func fetchItem<V: PersistentModel>() -> [V]? {
        do {
            let items = try modelContext.fetch(FetchDescriptor<V>())
            return items
        } catch {
            fatalError(SwiftDataError.fetchError.description)
        }
    }

    public func deleteItem(item: T) {
        modelContext.delete(item)
    }
}
