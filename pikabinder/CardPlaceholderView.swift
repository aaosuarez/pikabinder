//
//  CardPlaceholderView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//
import SwiftUI

struct CardPlaceholder: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(.systemGray5))
            .opacity(isAnimating ? 0.5 : 1.0)
            .animation(
                .easeInOut(duration: 1.0).repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
            .aspectRatio(CARD_ASPECT_RATIO, contentMode: .fit)
    }
}

#Preview {
    VStack {
        CardPlaceholder()
    }.padding()
}
