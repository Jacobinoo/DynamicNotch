//
//  VisionProtectView.swift
//  DynamicNotch
//
//  Created by Jakub on 17/12/2024.
//

import SwiftUI

struct TimerActivityView: View {
    @EnvironmentObject var viewModel: NotchViewModel
    @State private var timeRemaining: Int = 3
    @State private var mode: ActivitySize = .compact
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Group {
            switch mode {
            case .compact:
                compact
            case .expanded:
                expanded
            }
        }.onReceive(timer) { time in
            print(time)
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                self.timer.upstream.connect().cancel()
                viewModel.notchActivity?.expand()
                self.mode = .expanded
            }
        }
    }
    
    var compact: some View {
        HStack {
            compactLeading
                .frame(width: viewModel.notchFrame.width*0.15)
            Spacer()
            compactTrailing
                .frame(width: viewModel.notchFrame.width*0.2)
        }
        .foregroundStyle(.white)
    }
    
    var compactLeading: some View {
        ZStack {
            HStack {
                Image(systemName: "timer")
                    .foregroundStyle(.orange)
                    .font(.system(size: 17, weight: .semibold))
            }.padding(.leading, 1)
        }
    }
    
    var compactTrailing: some View {
        ZStack {
            HStack {
                Text("\(timeRemaining)")
                    .foregroundStyle(.orange)
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .lineLimit(1)
            }
        }
    }
    
    var expanded: some View {
        VStack(spacing: 8) {
            Spacer()
            if timeRemaining < 1 {
                Text("Timer")
                    .font(.title)
                Button {
                    forceStopActivity()
                } label: {
                    Text("Stop")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(in: RoundedRectangle(cornerRadius: 20))
                        .backgroundStyle(.orange)
                }
                .buttonStyle(.plain)
                .buttonBorderShape(.capsule)
            } else {
                Button {
                    
                } label: {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color.orange)
                        .background(Color.orange.opacity(0.35))
                        .clipShape(Circle())
                }
                .buttonStyle(.borderless)
            }
        }
        .foregroundStyle(.white)
        .padding(.bottom, 12)
    }
    
    func forceStopActivity() {
        viewModel.endActivity(reason: .force)
    }
}

struct CircularIOSButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.blue : Color.white)
            .background(configuration.isPressed ? Color.white : Color.blue)
            .cornerRadius(6.0)
            .padding(20)
    }
}
