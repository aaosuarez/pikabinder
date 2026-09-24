//
//  PikabinderApp.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftData
import SwiftUI

@main
struct PikabinderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: OwnedCard.self) { result in
                    switch result {
                    case .success(let container):
                        seedOwnedCardsIfNeeded(into: container.mainContext)
                    case .failure(let error):
                        print("Failed to set up model container: \(error)")
                    }
                }
        }
    }
}
