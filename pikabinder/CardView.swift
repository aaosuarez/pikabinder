//
//  CardView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftUI

struct CardView: View {
    let card: Card
    let isOwned: Bool
    
    var body: some View {
        AsyncImage(url: card.images.small) { image in
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
        card: Card(id: "test", name: "Pikachu", images: Card.Images(small: URL(string: "https://images.pokemontcg.io/base1/58.png")!)),
        isOwned: true
    )
}
