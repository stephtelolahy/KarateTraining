//
//  KarateTrainingApp.swift
//  KarateTraining
//
//  Created by Hugues Stéphano TELOLAHY on 19/09/2026.
//

import SwiftUI

@main
struct KarateTrainingApp: App {
    @State private var store = ContentStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(store)
        }
    }
}
