//
//  pikabinderTests.swift
//  pikabinderTests
//
//  Created by Aaron Suarez on 9/23/26.
//

import Testing
import Foundation

@testable import pikabinder

struct pikabinderTests {

    @Test func decodesStaticCards() async throws {
        let cardResposity = await CardRepository()
        let cards = await cardResposity.loadCards()

        #expect(cards.count > 0)
        #expect(!cards[0].id.isEmpty)
        await #expect(!cards[0].images.small.absoluteString.isEmpty)
    }

}
