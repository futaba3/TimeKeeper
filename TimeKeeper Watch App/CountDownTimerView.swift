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
            // 残り時間が30秒前になったらアラートを数字の上部に表示して10秒後に消える
            if viewModel.timeRemaining == 30 {
                Text("30秒前")
                    .font(.title)
                    .foregroundColor(.red)
                    .transition(.move(edge: .top))
                    .animation(.easeInOut(duration: 1))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                            withAnimation {
                                viewModel.timeRemaining = 0
                            }
                        }
                    }
            }
            
            if viewModel.timeRemaining >= 3600 {
                Text("\(viewModel.hours, specifier: "%02d"):\(viewModel.minutes, specifier: "%02d"):\(viewModel.seconds, specifier: "%02d")")
                    .font(.largeTitle)
                    .monospacedDigit() // 数字の幅が一定になるフォントスタイル
            } else {
                Text("\(viewModel.minutes, specifier: "%02d"):\(viewModel.seconds, specifier: "%02d")")
                    .font(.largeTitle)
                    .monospacedDigit()
            }
            Button(action: {
                viewModel.stopTimer()
            }, label: {
                Text("ストップ")
            })
            Button(action: {
                viewModel.resetTimer()
                isTimerRunning = false
            }, label: {
                Text("リセット")
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
