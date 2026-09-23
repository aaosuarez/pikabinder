//
//  ContentView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftUI
import Foundation

let cardRepository = CardRepository()

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
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }.padding(.horizontal)
        }
        .task {
            cards = cardRepository.loadCards()
        }
    }
}

#Preview {
    ContentView()
}
