//
//  CardRepository.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//
import Foundation

/// Matches the paginated envelope from the Pokémon TCG API,
/// where the cards are nested under the `data` key.
struct CardsResponse: Decodable {
    let data: [Card]
}

/// Decodes a JSON resource from the app bundle into a `Decodable` type.
func decode<T: Decodable>(_ file: String) -> T {
    guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
        fatalError("Couldn't find \(file) in the app bundle.")
    }
    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Couldn't decode \(file):\n\(error)")
    }
}
