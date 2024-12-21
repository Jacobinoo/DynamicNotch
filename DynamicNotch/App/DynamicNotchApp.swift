//
//  DynamicNotchApp.swift
//  DynamicNotch
//
//  Created by Jakub on 27/03/2024.
//

import SwiftUI

@main
struct DynamicNotchApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Window("DynamicNotch", id: "settings") {
            Text("Settings")
        }
        MenuBarExtra("DynamicNotch", systemImage: "bolt.horizontal.fill") {
            Section {
                Text("DynamicNotch")
            }
        }
    }
}
