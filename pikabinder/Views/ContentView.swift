//
//  ContentView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import Foundation
import SwiftData
import SwiftUI

let cardRepository = CardRepository()

struct ContentView: View {
    @Query var ownedCards: [OwnedCard]
    var ownedCardIds: Set<String> { Set(ownedCards.map(\.cardId)) }

    @State private var cards: [Card] = []
    @State private var selectedCard: Card? = nil

    var sortedCards: [Card] {
        print(cards.count)
        return cards.sorted { a, b in
            let isAOwned = ownedCardIds.contains(a.id)
            let isBOwned = ownedCardIds.contains(b.id)
            return isAOwned && !isBOwned
        }
    }

    let columns = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(sortedCards) { card in
                    CardView(
                        card: card,
                        color: ownedCardIds.contains(card.id)
                            ? CardColor.fullColor : CardColor.grayscale
                    )
                    .onTapGesture {
                        selectedCard = card
                    }
                }
            }
            .padding(.horizontal)
            .sheet(item: $selectedCard) { card in
                CardDetailView(card: card)
                    .presentationDetents([.medium, .large])

            }
        }
        .task {
            cards = cardRepository.loadCards()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: OwnedCard.self, inMemory: true)
}
