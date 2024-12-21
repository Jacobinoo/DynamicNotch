//
//  NotchView.swift
//  DynamicNotch
//
//  Created by Jakub on 27/03/2024.
//

import SwiftUI

struct NotchView: View {
    @EnvironmentObject var viewModel: NotchViewModel
    
    var body: some View {
        ZStack {
            Color.black
            switch viewModel.notchActivity {
            case is VisionProtectActivity:
                VisionProtectView()
            case is TimerActivity:
                TimerActivityView()
            case is StandUpActivity:
                StandUpActivityView()
            default:
                EmptyView()
            }
        }
        .onHover(perform: { isHovered in
//            if isHovered {
//                withAnimation {
//                    viewModel.expandNotch(withPurposeOf: .hover)
//                }
//            } else {
//                withAnimation {
//                    viewModel.resetNotchSize()
//                }
//            }
        })
        .frame(width: viewModel.notchFrame.width, height: viewModel.notchFrame.height)
        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 10, bottomTrailingRadius: 10))
        .clipped()
    }
}

#Preview {
    NotchView()
        .padding()
}
