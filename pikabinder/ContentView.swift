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

    let columns = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(cards) { card in
                    CardView(card: card, isOwned: ownedCardIds.contains(card.id))
                        .onTapGesture {
                            selectedCard = card
                        }
                }
            }
            .padding(.horizontal)
            .sheet(item: $selectedCard) { card in
                CardDetailView(card: card)
            }
        }
        .task {
            cards = cardRepository.loadCards().sorted { a, b in
                let isAOwned = ownedCardIds.contains(a.id)
                let isBOwned = ownedCardIds.contains(b.id)
                return isAOwned && !isBOwned
            }
        }
    }
}

#Preview {
    ContentView()
}
