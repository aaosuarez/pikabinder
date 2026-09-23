//
//  ContentView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftUI
import Foundation

/// Matches the paginated envelope from the Pokémon TCG API,
/// where the cards are nested under the `data` key.
struct CardsResponse: Decodable {
    let data: [Card]
}

struct Card: Decodable, Identifiable {
    let id: String
    let name: String
    let images: Images

    struct Images: Decodable {
        let small: URL
        let large: URL
    }
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

/// Loads the cards, unwrapping the top-level `data` array.
func loadCards() -> [Card] {
    let response: CardsResponse = decode("cards.json")
    return response.data
}

struct ContentView: View {
    @State private var cards: [Card] = []
    
    var body: some View {
        VStack {
            List(cards) { card in
                Text(card.name)
            }
        }
        .padding()
        .onAppear() {
            cards = loadCards()
        }
    }
}

#Preview {
    ContentView()
}
