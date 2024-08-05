//
//  AsteroidsApp.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//

import SwiftUI

@main
struct AsteroidsApp: App {
    @StateObject private var manager = GameManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(manager)
        }
    }
}
