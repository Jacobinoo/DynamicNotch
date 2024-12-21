//
//  NotchViewModel.swift
//  DynamicNotch
//
//  Created by Jakub on 22.09.2024.
//

import Foundation
import SwiftUI

enum ActivityDismissalReason {
    case force
    case timeout
}

protocol NotchActivity {
    static var timeToDie: TimeInterval { get }
    var disapearAfterTimer: Timer { get }
    static var supportedFrameSizes: [ActivitySize : CGSize] { get }
    var frameSize: CGSize { get set }
    
    static func dismiss(_ reason: ActivityDismissalReason)
}
enum ActivitySize {
    case small
    case medium
    case large
}

struct VisionProtectActivity: NotchActivity {
    static let supportedFrameSizes: [ActivitySize : CGSize] = [
        .small: CGSize(width: AppDelegate.screen.notchSize.width+70, height: AppDelegate.screen.notchSize.height+41),
    ]
    static let timeToDie: TimeInterval = 10
    var disapearAfterTimer: Timer
    var frameSize: CGSize
    
    init() {
        self.frameSize = VisionProtectActivity.supportedFrameSizes[.small]!
        self.disapearAfterTimer = Timer.scheduledTimer(withTimeInterval: VisionProtectActivity.timeToDie, repeats: false, block: {_ in VisionProtectActivity.dismiss(.timeout)})
    }
    
    static func dismiss(_ reason: ActivityDismissalReason) {
        switch reason {
        case .force:
            AppDelegate.notchViewModel.endActivity()
        case .timeout:
            AppDelegate.notchViewModel.endActivity()
        }
    }
}

enum NotchExpandType {
    case hover
    case defaultExpand
}

enum NotchSizeResetReason {
    case activityEnd
    case force
}

class NotchViewModel: NSObject, ObservableObject {
    @Published var notchFrame: CGSize = AppDelegate.screen.notchSize
    @Published var hoverAdditionalFrame: CGSize?
    @Published var notchActivity: NotchActivity?
    @Published var isNotchBeingHovered: Bool = false
    
    func startActivity(_ activity: NotchActivity) {
        withAnimation {
            AppDelegate.notchViewModel.notchActivity = activity
            AppDelegate.notchViewModel.notchFrame = activity.frameSize
        }
    }
    
    func endActivity() {
        // Check if the cursor is still hovering over the notch
        if isNotchBeingHovered {
            // Defer the activity end by waiting for the hover to end
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Poll every 500ms
                self.endActivity() // Retry ending activity
            }
        } else {
            // Safe to reset notch size and activity
            withAnimation {
                AppDelegate.notchViewModel.resetNotchSize(reason: .activityEnd)
                AppDelegate.notchViewModel.notchActivity = nil
            }
        }
    }

    func expandNotch(withPurposeOf type: NotchExpandType) {
        switch type {
        case .hover:
            notchFrame.width = notchFrame.width + 8
            notchFrame.height = notchFrame.height + 2
        case .defaultExpand:
            notchFrame.width = AppDelegate.screen.notchSize.width + 50
            notchFrame.height = AppDelegate.screen.notchSize.height + 100
        }
    }
    
    func resetNotchSize(reason: NotchSizeResetReason) {
        switch reason {
            case .activityEnd:
                notchFrame = AppDelegate.screen.notchSize
            case .force:
                notchFrame = AppDelegate.screen.notchSize
        }
    }
    
}
