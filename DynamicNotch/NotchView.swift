//
//  NotchView.swift
//  DynamicNotch
//
//  Created by Jakub on 27/03/2024.
//

import SwiftUI

struct NotchView: View {
    @State private var cursorOverNotch: Bool = false
    private let eyesProtectReminderInterval: TimeInterval = 1 * 30
    @State private var eyesProtectViewDisplayed: Bool = false
    
    var scaleAnimation: Animation {
        Animation.easeInOut
    }
    
    var body: some View {
        withAnimation(scaleAnimation) {
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 12.5, bottomTrailingRadius: 12.5, topTrailingRadius: 0)
                .fill(.black)
                .scaleEffect(cursorOverNotch ? 1.05 : 1)
                .frame(width: CGFloat(Screen.notchWidth), height: CGFloat(eyesProtectViewDisplayed ? Screen.notchHeight+70 : Screen.notchHeight))
                .onHover(perform: { isHovering in
                    withAnimation {
                        cursorOverNotch = isHovering
                    }
                })
                .onAppear {
                    scheduleEyesProtectReminders()
                }
        }
        if eyesProtectViewDisplayed {
            EyesProtectView(isDisplayed: $eyesProtectViewDisplayed)
                .padding(.vertical, 50)
        }
    }
    
    private func scheduleEyesProtectReminders() {
        let timer = Timer.scheduledTimer(withTimeInterval: eyesProtectReminderInterval, repeats: true) { timer in
            withAnimation {
                eyesProtectViewDisplayed = true
            }
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    withAnimation {
                        eyesProtectViewDisplayed = false
                    }
                }
        }
        timer.tolerance = eyesProtectReminderInterval * 0.25
    }
}

#Preview {
    NotchView()
        .padding()
}
