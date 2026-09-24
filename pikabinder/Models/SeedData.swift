//
//  SeedData.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/24/26.
//

import Foundation
import SwiftData

/// The initial owned-card collection, seeded into SwiftData on first launch.
let seedCardIds: [String] = [
    "cel25-5",
    "sm12-241",
    "swsh4-43",
    "swshp-SWSH063",
    "swshp-SWSH061",
    "cel25-8",
    "cel25-6",
    "swsh11-52",
    "sm115-19",
    "sm11-55",
    "g1-26",
    "swshp-SWSH234",
    "swsh12-49",
    "pgo-27",
    "sm35-28",
    "sm12-66",
    "smp-SM234",
    "swsh7-49",
    "sv4pt5-18",
    "smp-SM232",
    "xy12-35",
    "swsh8-86",
    "sv3pt5-173",
    "sv3pt5-25",
    "sv5-51",
    "smp-SM76",
]

/// Tracks whether the initial owned-card seed has already run.
/// Using a flag (rather than checking for an empty store) means we won't
/// re-seed if the user deliberately removes every card.
private let didSeedOwnedCardsKey = "didSeedOwnedCards"

/// Seeds the initial owned cards exactly once, guarded by a `UserDefaults` flag.
@MainActor
func seedOwnedCardsIfNeeded(into context: ModelContext) {
    guard !UserDefaults.standard.bool(forKey: didSeedOwnedCardsKey) else {
        return
    }

    for cardId in seedCardIds {
        context.insert(OwnedCard(cardId: cardId))
    }

    // Persist immediately so the flag and the data can't drift apart if the
    // app is terminated before autosave runs.
    try? context.save()

    UserDefaults.standard.set(true, forKey: didSeedOwnedCardsKey)
}
