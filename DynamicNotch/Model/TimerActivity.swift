//
//  TimerActivity.swift
//  DynamicNotch
//
//  Created by Jakub on 19/12/2024.
//


import Cocoa
import SwiftUI

struct TimerActivity: NotchActivity {
    static let supportedFrameSizes: [ActivitySize : CGSize] = [
        .compact: CGSize(width: AppDelegate.screen.notchSize.width+75, height: AppDelegate.screen.notchSize.height),
        .expanded: CGSize(width: AppDelegate.screen.notchSize.width+80, height: AppDelegate.screen.notchSize.height*4),
    ]
    static let timeToDie: TimeInterval = 0
    var frameSize: CGSize {
        didSet {
            AppDelegate.notchViewModel.notchFrame = frameSize
        }
    }
    
    init() {
        self.frameSize = TimerActivity.supportedFrameSizes[.compact]!
    }
    
    mutating func expand() {
        withAnimation {
            frameSize = TimerActivity.supportedFrameSizes[.expanded]!
        }
    }
    
    static func dismiss(_ reason: ActivityDismissalReason) {
        switch reason {
        case .force:
            AppDelegate.notchViewModel.endActivity(reason: .force)
        case .timeout:
            AppDelegate.notchViewModel.endActivity(reason: .activityEnd)
        }
    }
}
