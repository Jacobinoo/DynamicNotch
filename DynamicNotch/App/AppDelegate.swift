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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
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
        
        DispatchQueue.main.async {
            let timer = Timer.scheduledTimer(withTimeInterval: 20*60, repeats: true) { _ in
                AppDelegate.notchViewModel.startActivity(VisionProtectActivity())
            }
            timer.tolerance = 1
            timer.fire()
        }
    }
}
