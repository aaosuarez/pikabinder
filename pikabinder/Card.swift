//
//  Card.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//
import Foundation

struct Card: Decodable, Identifiable {
    static var aspectRatio: CGFloat = 2.5/3.5

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
