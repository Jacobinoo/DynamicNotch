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
    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let xPos: Int = Int(Screen.size.width) / 2 - Screen.maxNotchWidth/2
        let yPos: Int = (Int(Screen.size.height) - Screen.maxNotchHeight) + Screen.additionalHeightForHover
        
        window = NSWindow(
            contentRect: NSRect(x: xPos, y: yPos, width: Screen.maxNotchWidth, height: Screen.maxNotchHeight),
            styleMask: .borderless,
            backing: .buffered, defer: false)
        
        window.level = .screenSaver
        window.hasShadow = false
        window.backgroundColor = .clear
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }
}
