//
//  ContentView.swift
//  DynamicNotch
//
//  Created by Jakub on 27/03/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: NotchViewModel
    @State private var notchScale: CGFloat = 1
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.clear)
            NotchView()
                .scaleEffect(notchScale)
                .onHover { isHovering in
                    viewModel.isNotchBeingHovered = isHovering
                    if isHovering {
                        withAnimation {
                            self.notchScale = 1.03
                        }
                    } else {
                        withAnimation {
                            self.notchScale = 1
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
