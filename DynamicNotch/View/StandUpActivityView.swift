//
//  StandUpActivityView.swift
//  DynamicNotch
//
//  Created by Jakub on 17/12/2024.
//

import SwiftUI

struct StandUpActivityView: View {
    @EnvironmentObject var viewModel: NotchViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("Stand Up")
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .foregroundStyle(.cyan)
            Text("Do not sit for 2 minutes from now")
                .font(.caption2)
                .foregroundStyle(.white)
        }.padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}
