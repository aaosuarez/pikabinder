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
    var systemImage: String {
        switch self {
        case .all: return "rectangle.grid.3x2"
        case .owned: return "rectangle.portrait.fill"
        case .missing: return "rectangle.portrait"
        }
    }
}

enum LanguageFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case english = "English"
    case japanese = "Japanese"

    var id: Self { self }
    var systemImage: String {
        switch self {
        case .all: return "globe"
        case .english: return "character"
        case .japanese: return "character.ja"
        }
    }
}

struct ContentView: View {
    @Query var ownedCards: [OwnedCard]
    var ownedCardIds: Set<String> { Set(ownedCards.map(\.cardId)) }

    @State private var cards: [Card] = []
    @State private var selectedCard: Card? = nil

    @State private var collectionFilter: CollectionFilter = .all
    @State private var languageFilter: LanguageFilter = .all

    var visibleCards: [Card] {
        let ownedIds = ownedCardIds
        return
            cards
            .filter { card in
                switch collectionFilter {
                case .all:
                    return true
                case .owned:
                    return ownedIds.contains(card.id)
                case .missing:
                    return !ownedIds.contains(card.id)
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
                ownedIds.contains(a.id) && !ownedIds.contains(b.id)
            }
    }

    let columns = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
    ]

    var body: some View {
        let ownedIds = ownedCardIds
        let hasActiveFilter = collectionFilter != .all || languageFilter != .all

        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(visibleCards) { card in
                        CardView(
                            card: card,
                            color: ownedIds.contains(card.id)
                                ? CardColor.fullColor : CardColor.grayscale
                        )
                        .onTapGesture {
                            selectedCard = card
                        }
                    }
                }
                .padding(.horizontal)
            }
            .sheet(item: $selectedCard) { card in
                CardDetailView(card: card)
                    .presentationDetents([.medium, .large])

            }
            .task {
                cards = cardRepository.loadCards()
            }
            .toolbar {
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Menu {
                        Section("Collection") {
                            Picker(
                                "CollectionFilter",
                                selection: $collectionFilter
                            ) {
                                ForEach(CollectionFilter.allCases) { filter in
                                    Label(
                                        filter.rawValue,
                                        systemImage: filter.systemImage
                                    )
                                }
                            }
                            .pickerStyle(.inline)
                        }

                        Section("Language") {
                            Picker("LanguageFilter", selection: $languageFilter)
                            {
                                ForEach(LanguageFilter.allCases) { filter in
                                    Label(
                                        filter.rawValue,
                                        systemImage: filter.systemImage
                                    )                                }
                            }
                            .pickerStyle(.inline)
                        }
                    } label: {
                        Image(
                            systemName: hasActiveFilter
                                ? "line.3.horizontal.decrease.circle.fill"
                                : "line.3.horizontal.decrease.circle"
                        )
                    }
                    .menuOrder(.fixed)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: OwnedCard.self, inMemory: true)
}
