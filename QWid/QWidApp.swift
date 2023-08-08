//
//  QWidApp.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/1/23.
//

import SwiftUI

@main
struct QWidApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            QWQAView(model: QWPersonDataViewModel())
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
