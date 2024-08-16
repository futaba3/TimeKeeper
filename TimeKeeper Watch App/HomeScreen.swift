//
//  HomeScreen.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/16.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var timerViewModel = CountDownTimerViewModel()
    @StateObject private var timePickerViewModel = EndTimePickerViewModel()
    
    @State private var isTimerRunning = false
    
    var body: some View {
        NavigationStack {
            if isTimerRunning {
                CountDownTimerView(viewModel: timerViewModel, isTimerRunning: $isTimerRunning)
                    .onDisappear{
                        isTimerRunning = false
                    }
            } else {
                EndTimePickerView(viewModel: timePickerViewModel) { selectedTime in
                    timerViewModel.startTimer(duration: selectedTime)
                    isTimerRunning = true
                }
            }
            
        }
    }
}

#Preview {
    HomeScreen()
}
