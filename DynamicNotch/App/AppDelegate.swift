//
//  AppDelegate.swift
//  DynamicNotch
//
//  Created by Jakub on 27/03/2024.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    let contentView = ContentView()
    static let screen = NSScreen.main!
    private let _screen = AppDelegate.screen
    var window: NSWindow!
    static var notchViewModel = NotchViewModel()
    static let hoverFix = 1
    var visionProtectTimer: Timer = Timer.scheduledTimer(withTimeInterval: 20*60, repeats: true) { _ in
        AppDelegate.notchViewModel.startActivity(VisionProtectActivity())
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        visionProtectTimer.tolerance = 0.1
        window = NSWindow(
            contentRect: NSRect(x: CGFloat(0), y: CGFloat(0+AppDelegate.hoverFix), width: _screen.frame.width, height: _screen.frame.height),
            styleMask: [.borderless, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.level = .statusBar + 8 // kills ibar
        window.collectionBehavior = [.fullScreenAuxiliary, .stationary, .canJoinAllSpaces, .ignoresCycle]
        window.hasShadow = false
        window.backgroundColor = NSColor.clear
        window.contentView = NSHostingView(rootView: contentView.environmentObject(AppDelegate.notchViewModel))
        window.makeKeyAndOrderFront(nil)
    }
    
    func forceVisionProtectAlert() {
        DispatchQueue.main.async {
            self.visionProtectTimer.fire()
        }
    }
}
