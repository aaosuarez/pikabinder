//
//  Card.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//
import Foundation

struct Card: Decodable, Identifiable {
    static var aspectRatio = 2.5 / 3.5

    let id: String
    let name: String
    let images: Images

    struct Images: Decodable {
        let small: URL
        let large: URL
    }
}

/// Matches the paginated envelope from the Pokémon TCG API,
/// where the cards are nested under the `data` key.
struct CardsResponse: Decodable {
    let data: [Card]
}

let ownedCards = Set([
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
])
