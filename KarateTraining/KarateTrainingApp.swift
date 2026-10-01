//
//  KarateTrainingApp.swift
//  KarateTraining
//
//  Created by Hugues Stéphano TELOLAHY on 19/09/2026.
//

import Foundation
import SwiftUI

@main
struct KarateTrainingApp: App {
    @State private var store = ContentStore()

    init() {
        // AsyncImage passe par URLCache.shared : on l'agrandit pour garder les
        // photos des techniques entre les lancements (défaut ≈ 10 Mo disque).
        URLCache.shared = URLCache(
            memoryCapacity: 20 * 1024 * 1024,
            diskCapacity: 200 * 1024 * 1024
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
