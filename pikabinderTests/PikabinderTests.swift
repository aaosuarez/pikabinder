//
//  PikabinderTests.swift
//  pikabinderTests
//
//  Created by Aaron Suarez on 9/23/26.
//

import Testing
import Foundation

@testable import pikabinder

@MainActor struct PikabinderTests {

    @Test func decodesStaticCards() async throws {
        let cardRepository = CardRepository()
        let cards = cardRepository.loadCards()
        let card = cards.first(where: { $0.id == "base1-58" })
        
        #expect(card?.name == "Pikachu")
        #expect(card?.images.small.absoluteString.isEmpty == false)
    }
}
