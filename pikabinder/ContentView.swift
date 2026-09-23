//
//  ContentView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftUI
import Foundation

let cardRepository = CardRepository()
let CARD_ASPECT_RATIO = 2.5/3.5

struct ContentView: View {
    @State private var cards: [Card] = []
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns) {
                ForEach(cards) { card in
                    AsyncImage(url: card.images.small) { image in
                        image
                            .resizable()
                    } placeholder: {
                        CardPlaceholder()
                    }
                }
                .aspectRatio(CARD_ASPECT_RATIO, contentMode: .fit)
            }
            .padding(.horizontal)
        }
        .task {
            cards = cardRepository.loadCards()
        }
    }
}

#Preview {
    ContentView()
}
