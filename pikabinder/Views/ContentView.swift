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

enum CollectionFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case owned = "Owned"
    case missing = "Missing"

    var id: Self { self }
}

enum LanguageFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case english = "English"
    case japanese = "Japanese"
    
    var id: Self { self }
}

struct ContentView: View {
    @Query var ownedCards: [OwnedCard]
    var ownedCardIds: Set<String> { Set(ownedCards.map(\.cardId)) }

    @State private var cards: [Card] = []
    @State private var selectedCard: Card? = nil

    @State private var collectionFilter: CollectionFilter = .all
    @State private var languageFilter: LanguageFilter = .all
   
    var visibleCards: [Card] {
        cards
            .filter { card in
                switch collectionFilter {
                case .all:
                    return true
                case .owned:
                    return ownedCardIds.contains(card.id)
                case .missing:
                    return !ownedCardIds.contains(card.id)
                }
            }
            .filter { card in
                switch languageFilter {
                case .all:
                    return true
                case .english:
                    return card.language_code == "EN"
                case .japanese:
                    return card.language_code == "JA"
                }
            }
            .sorted { a, b in
                ownedCardIds.contains(a.id) && !ownedCardIds.contains(b.id)
            }
    }

    let columns = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(visibleCards) { card in
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Filter") {
                        Section("Collection") {
                            Picker("CollectionFilter", selection: $collectionFilter) {
                                ForEach(CollectionFilter.allCases) { filter in
                                    Text(filter.rawValue).tag(filter)
                                }
                            }
                            .pickerStyle(.inline)
                        }
                        
                        Section("Language") {
                            Picker("LanguageFilter", selection: $languageFilter) {
                                ForEach(LanguageFilter.allCases) { filter in
                                    Text(filter.rawValue).tag(filter)
                                }
                            }
                            .pickerStyle(.inline)
                        }
                    }
                }
            }
            .navigationTitle("Pikabinder")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: OwnedCard.self, inMemory: true)
}
