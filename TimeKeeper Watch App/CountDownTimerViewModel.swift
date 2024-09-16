//
//  CountDownTimerViewModel.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/16.
//

import SwiftUI
import Combine

class CountDownTimerViewModel: ObservableObject {
    @Published var timeRemaining: TimeInterval = 0
    @Published var remainTimeAlertIsVisible: Bool = false
    @Published var isBlinking: Bool = false
    @Published var timerState: TimerState = .stopped
    
    private var timer: AnyCancellable?
    
    enum TimerState {
        case running
        case stopped
        case paused
    }
    
    var hours: Int {
        return Int(timeRemaining) / 3600
    }
    
    var minutes: Int {
        return (Int(timeRemaining) % 3600) / 60
    }
    
    var seconds: Int {
        return Int(timeRemaining) % 60
    }
    
    func startTimer(duration: TimeInterval) {
        self.timeRemaining = duration
        timer?.cancel()
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                updateTime()
            }
    }
    
    private func updateTime() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            if timeRemaining == 30 {
                startBlinking()
            }
        } else {
            timer?.cancel()
        }
    }
    
    func stopTimer() {
        timer?.cancel()
        timerState = .paused
    }
    
    func resetTimer() {
        timer?.cancel()
        timeRemaining = 0
        timerState = .stopped
    }
    
    func startBlinkingAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                isBlinking = true
            }
    }
    
    func stopBlinkingAnimation() {
        isBlinking = false
        remainTimeAlertIsVisible = false
    }
    
    func startBlinking() {
        remainTimeAlertIsVisible = true
        startBlinkingAnimation()
        
        // 5秒後に点滅を止める
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.stopBlinkingAnimation()
            }
        
//        withAnimation(Animation.easeOut(duration: 1.0).repeatForever(autoreverses: true)) {
//            self.isBlinking = true
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.isBlinking = false
//            self.remainTimeAlertIsVisible = false
//        }
//        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
//                withAnimation(Animation.easeOut(duration: 0.5)) {
//                    self.isBlinking.toggle()
//                }
//                // 5秒後にタイマーを無効化してアラートを消す
//                if self.timeRemaining > 30 || self.timeRemaining == 0 {
//                    timer.invalidate()
//                    DispatchQueue.main.async {
//                        self.isBlinking = false
//                        self.remainTimeAlertIsVisible = false
//                    }
//                }
//            }
    }
}
