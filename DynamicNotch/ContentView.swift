//
//  ContentView.swift
//  DynamicNotch
//
//  Created by Jakub on 27/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.clear)
            NotchView()
        }
        .clipped()
    }
}

#Preview {
    ContentView()
}
