//
//  NotchActivity.swift
//  DynamicNotch
//
//  Created by Jakub on 19/12/2024.
//

import Cocoa

protocol NotchActivity {
    static var timeToDie: TimeInterval { get }
    static var supportedFrameSizes: [ActivitySize : CGSize] { get }
    var frameSize: CGSize { get set }
    
    static func dismiss(_ reason: ActivityDismissalReason)
    
    mutating func expand()
}
