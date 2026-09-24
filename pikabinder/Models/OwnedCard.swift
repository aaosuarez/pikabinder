//
//  OwnedCard.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/24/26.
//

import Foundation
import SwiftData

@Model
class OwnedCard {
    @Attribute(.unique) var cardId: String

    init(cardId: String) {
        self.cardId = cardId
    }
}
