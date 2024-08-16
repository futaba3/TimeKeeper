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
    private var timer: AnyCancellable?
    
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
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.cancel()

                }
            }
    }
    
    func stopTimer() {
        timer?.cancel()
    }
}
