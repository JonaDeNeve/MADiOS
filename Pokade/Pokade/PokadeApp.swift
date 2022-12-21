//
//  PokadeApp.swift
//  Pokade
//
//  Created by Jona De Neve on 21/12/2022.
//

import SwiftUI

@main
struct PokadeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
