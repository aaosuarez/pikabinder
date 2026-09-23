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
    
    var body: some View {
        VStack {
            List(cards) { card in
                Text(card.name)
            }
        }
        .padding()
        .onAppear() {
            cards = cardRepository.loadCards()
        }
    }
}

#Preview {
    ContentView()
}
