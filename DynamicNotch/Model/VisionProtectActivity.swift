//
//  VisionProtectActivity.swift
//  DynamicNotch
//
//  Created by Jakub on 19/12/2024.
//

import Cocoa

struct VisionProtectActivity: NotchActivity {
    static let supportedFrameSizes: [ActivitySize : CGSize] = [
        .expanded: CGSize(width: AppDelegate.screen.notchSize.width+70, height: AppDelegate.screen.notchSize.height+41),
    ]
    static let timeToDie: TimeInterval = 10
    var disapearAfterTimer: Timer
    var frameSize: CGSize
    
    init() {
        self.frameSize = VisionProtectActivity.supportedFrameSizes[.expanded]!
        self.disapearAfterTimer = Timer.scheduledTimer(withTimeInterval: VisionProtectActivity.timeToDie, repeats: false, block: {_ in VisionProtectActivity.dismiss(.timeout)})
    }
    
    static func dismiss(_ reason: ActivityDismissalReason) {
        switch reason {
        case .force:
            AppDelegate.notchViewModel.endActivity(reason: .force)
        case .timeout:
            AppDelegate.notchViewModel.endActivity(reason: .activityEnd)
        }
    }
    
    mutating func expand() {}
}
