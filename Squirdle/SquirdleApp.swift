//
//  SquirdleApp.swift
//  Squirdle
//
//  Created by Jona De Neve on 15/12/2022.
//

import SwiftUI

@main
struct SquirdleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
