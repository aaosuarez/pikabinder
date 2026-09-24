//
//  CardView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftUI

enum CardSize {
    case small
    case large
}

struct CardView: View {
    let card: Card
    let isOwned: Bool
    var size: CardSize = CardSize.small

    func getCardImageUrl() -> URL {
        switch size {
        case .small:
            return card.images.small
        case .large:
            return card.images.large
        }
    }

    var body: some View {
        AsyncImage(url: getCardImageUrl()) { image in
            image
                .resizable()
                .grayscale(isOwned ? 0 : 1)
        } placeholder: {
            CardPlaceholderView()
        }
        .aspectRatio(Card.aspectRatio, contentMode: .fit)
    }
}

#Preview {
    CardView(
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
        ),
        isOwned: true
    )
}
