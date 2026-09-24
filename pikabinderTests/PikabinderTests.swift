//
//  PikabinderTests.swift
//  pikabinderTests
//
//  Created by Aaron Suarez on 9/23/26.
//

import Foundation
import Testing

@testable import pikabinder

@MainActor struct PikabinderTests {

    @Test func decodesStaticCards() throws {
        let cardRepository = CardRepository()
        let cards = cardRepository.loadCards()
        let card = try #require(
            cards.first(where: { $0.id == "base1-58" }),
            "Card with id 'base1-58' not found"
        )
        #expect(card.name == "Pikachu")
    }
}
