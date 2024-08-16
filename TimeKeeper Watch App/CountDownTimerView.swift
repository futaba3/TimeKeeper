//
//  CountDownTimerView.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/16.
//

import SwiftUI

struct CountDownTimerView: View {
    @ObservedObject var viewModel: CountDownTimerViewModel
    @Binding var isTimerRunning: Bool
    
    var body: some View {
        VStack {
            // 残り時間が30秒前になったらアラートを数字の上部に表示して5秒後に消える
            if viewModel.remainTimeAlertIsVisible {
                Text("30秒前")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .opacity(viewModel.isBlinking ? 1.0 : 0.0)
                    .animation(Animation.easeOut(duration: 1.0).repeatForever(autoreverses: true), value: viewModel.isBlinking)
            } else {
                Text("")
            }
            
            if viewModel.timeRemaining >= 3600 {
                Text("\(viewModel.hours, specifier: "%02d"):\(viewModel.minutes, specifier: "%02d"):\(viewModel.seconds, specifier: "%02d")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .monospacedDigit() // 数字の幅が一定になるフォントスタイル
            } else {
                Text("\(viewModel.minutes, specifier: "%02d"):\(viewModel.seconds, specifier: "%02d")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .monospacedDigit()
            }
            Button(action: {
                viewModel.stopTimer()
            }, label: {
                Text("ストップ")
                    .fontWeight(.bold)
            })
            Button(action: {
                viewModel.resetTimer()
                isTimerRunning = false
            }, label: {
                Text("リセット")
                    .fontWeight(.bold)
            })
            .onAppear {
                viewModel.startTimer(duration: viewModel.timeRemaining)
            }
        }
    }
}

#Preview {
    CountDownTimerView(viewModel: CountDownTimerViewModel(), isTimerRunning: .constant(true))
}
