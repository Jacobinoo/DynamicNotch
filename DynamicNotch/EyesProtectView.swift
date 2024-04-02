//
//  EyesProtectView.swift
//  DynamicNotch
//
//  Created by Jakub on 02/04/2024.
//

import SwiftUI

struct EyesProtectView: View {
    @Binding var isDisplayed: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "eye.trianglebadge.exclamationmark")
                .font(.system(.title))
                .fontWeight(.bold)
                .imageScale(.large)
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(.white)
                .symbolEffect(.bounce.down, value: isDisplayed)
            Text("Take a break to protect your vision")
                .font(.system(.callout, design: .rounded))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var eyesProtectViewDisplayed = true
        
        var body: some View {
            ZStack {
                NotchView()
                EyesProtectView(isDisplayed: $eyesProtectViewDisplayed)
            }
            .padding()
        }
    }
    return Preview()
}
