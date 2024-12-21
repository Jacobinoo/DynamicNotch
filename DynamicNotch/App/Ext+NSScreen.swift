//
//  Ext+NSScreen.swift
//  DynamicNotch
//
//  Created by Jakub on 17/12/2024.
//

import Cocoa

extension NSScreen {
    var notchSize: CGSize {
        guard safeAreaInsets.top > 0 else { return .zero }
        let notchHeight = safeAreaInsets.top+Double(AppDelegate.hoverFix)
        let fullWidth = frame.width
        let leftPadding = auxiliaryTopLeftArea?.width ?? 0
        let rightPadding = auxiliaryTopRightArea?.width ?? 0
        guard leftPadding > 0, rightPadding > 0 else { return .zero }
        let notchWidth = fullWidth - leftPadding - rightPadding
        return CGSize(width: notchWidth, height: notchHeight)
    }
}
