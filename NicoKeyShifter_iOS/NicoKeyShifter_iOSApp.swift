//
//  NicoKeyShifter_iOSApp.swift
//  NicoKeyShifter_iOS
//
//  Created by 吉田誠 on 2025/05/06.
//

import SwiftUI
import SwiftData

@main
struct NicoKeyShifter_iOSApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SearchView()
        }
        .modelContainer(sharedModelContainer)
    }
}
