//
//  Card.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//
import Foundation

struct Card: Decodable, Identifiable {
    let id: String
    let name: String
    let images: Images

    struct Images: Decodable {
        let small: URL
        let large: URL
    }
}

struct CardRepository {
    /// Loads the cards, unwrapping the top-level `data` array.
    func loadCards() -> [Card] {
        let response: CardsResponse = decode("cards.json")
        return response.data
    }
}
