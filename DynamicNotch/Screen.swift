//
//  Screen.swift
//  DynamicNotch
//
//  Created by Jakub on 27/03/2024.
//

import Foundation
import Cocoa

struct Screen {
    static let mainScreen: NSScreen = NSScreen.main!
    static let frame: NSRect = mainScreen.frame
    static let size: NSSize = mainScreen.frame.size
    
    static let notchWidth: Int = Int(frame.width) - ((Int(mainScreen.auxiliaryTopLeftArea!.width)) * 2)
    static let maxNotchWidth: Int = notchWidth * 2
    
    static let notchHeight: Int = Int(mainScreen.safeAreaInsets.top)+additionalHeightForHover
    static let maxNotchHeight: Int = (notchHeight * 4)
    
    static let additionalHeightForHover: Int = 10
}
