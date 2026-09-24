//
//  CardDetailView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftUI

struct CardDetailView: View {
    let card: Card
    var body: some View {
        VStack {
            CardView(card: card, isOwned: true)
            Text(card.name)
        }
        .padding()
    }
}

#Preview {
    CardDetailView(card: Card(id: "test", name: "Pikachu", images: Card.Images(small: URL(string: "https://images.pokemontcg.io/base1/58.png")!)))
}
