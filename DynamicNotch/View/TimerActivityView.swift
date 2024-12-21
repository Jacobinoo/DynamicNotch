//
//  VisionProtectView.swift
//  DynamicNotch
//
//  Created by Jakub on 17/12/2024.
//

import SwiftUI

struct VisionProtectView: View {
    @EnvironmentObject var viewModel: NotchViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("Protect Your Vision")
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .foregroundStyle(.yellow)
            Text("Look away for a moment")
                .font(.caption2)
                .foregroundStyle(.white)
        }.padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}

#Preview {
    VisionProtectView()
}
