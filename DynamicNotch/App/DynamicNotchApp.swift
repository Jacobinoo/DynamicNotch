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
                Text("Dynamic Notch")
            }
            Button {
                appDelegate.forceVisionProtectAlert()
            } label: {
                Text("Force Vision Alert")
            }
            Button {
                appDelegate.forceStandUpReminder()
            } label: {
                Text("Force Stand Up Reminder")
            }
            Button {
                AppDelegate.notchViewModel.startActivity(TimerActivity())
            } label: {
                Text("Start 1-Min Timer")
            }
            Button {
                exit(0)
            } label: {
                Text("Exit")
            }
        }
    }
}
