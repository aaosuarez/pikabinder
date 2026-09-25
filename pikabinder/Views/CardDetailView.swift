//
//  CardDetailView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftData
import SwiftUI

struct CardDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Query var ownedCards: [OwnedCard]
    var ownedCardIds: Set<String> { Set(ownedCards.map(\.cardId)) }
    var isOwned: Bool {
        ownedCardIds.contains(card.id)
    }

    let card: Card
    var body: some View {
        VStack {
            CardView(card: card, size: .large)

            Button(role: isOwned ? .destructive : nil, action: handlePress) {
                Label(
                    isOwned ? "Remove" : "Add",
                    systemImage: isOwned ? "minus.circle" : "plus.circle"
                )
            }
            .buttonStyle(.glassProminent)
            .controlSize(.large)
        }
        .padding()
    }

    func handlePress() {
        if let ownedCard = ownedCards.first(where: { $0.cardId == card.id }) {
            modelContext.delete(ownedCard)
        } else {
            modelContext.insert(OwnedCard(cardId: card.id))
        }
    }
}

#Preview {
    CardDetailView(
        card: Card(
            id: "test",
            name: "Pikachu",
            images: Card.Images(
                small: URL(
                    string: "https://images.pokemontcg.io/base1/58.png"
                )!,
                large: URL(
                    string: "https://images.pokemontcg.io/base1/58_hires.png"
                )!
            )
        )
    )
    .modelContainer(for: OwnedCard.self, inMemory: true)
}
