//
//  NotchViewModel.swift
//  DynamicNotch
//
//  Created by Jakub on 22.09.2024.
//

import Foundation
import SwiftUI

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
    
    func endActivity(reason: NotchSizeResetReason) {
        // Check if the cursor is still hovering over the notch
        if isNotchBeingHovered && reason != .force {
            // Defer the activity end by waiting for the hover to end
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Poll every 500ms
                self.endActivity(reason: .activityEnd) // Retry ending activity
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
