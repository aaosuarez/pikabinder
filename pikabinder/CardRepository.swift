//
//  CardRepository.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//
import Foundation

struct CardRepository {
    /// Loads the cards, unwrapping the top-level `data` array.
    func loadCards() -> [Card] {
        let response: CardsResponse = decode("cards.json")
        return response.data
    }
}

/// Decodes a JSON resource from the app bundle into a `Decodable` type.
func decode<T: Decodable>(_ file: String) -> T {
    guard let url = Bundle.main.url(forResource: file, withExtension: nil)
    else {
        fatalError("Couldn't find \(file) in the app bundle.")
    }
    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Couldn't decode \(file):\n\(error)")
    }
}
