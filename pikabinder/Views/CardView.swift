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

enum CardColor {
    case fullColor
    case grayscale
}

struct CardView: View {
    let card: Card
    var color: CardColor = CardColor.fullColor
    var size: CardSize = CardSize.small

    func getCardImageUrl() -> URL {
        switch size {
        case .small:
            return card.images[0].small
        case .large:
            return card.images[0].large
        }
    }

    var body: some View {
        AsyncImage(url: getCardImageUrl()) { image in
            image
                .resizable()
                .grayscale(color == CardColor.grayscale ? 1 : 0)
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
            images: [Card.Image(
                small: URL(
                    string: "https://images.pokemontcg.io/base1/58.png"
                )!,
                large: URL(
                    string: "https://images.pokemontcg.io/base1/58_hires.png"
                )!
            )]
        ),
    )
}
