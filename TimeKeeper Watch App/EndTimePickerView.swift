//
//  EndTimePickerView.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/16.
//

import SwiftUI

struct EndTimePickerView: View {
    @ObservedObject var viewModel: EndTimePickerViewModel
    @ObservedObject var timerViewModel: CountDownTimerViewModel
    
    var onTimeSelected: (TimeInterval) -> Void
    
    var body: some View {
        VStack {
            Text("時間を設定")
                .font(.headline)
            
            HStack {
                Picker("時間", selection: $viewModel.selectedHour) {
                    ForEach(0..<24) { hour in
                        Text(String(format: "%02d", hour)).tag(hour)
                    }
                }
                .frame(width: 44)
                
                Text(":")
                
                Picker("分", selection: $viewModel.selectedMinute) {
                    ForEach(0..<60) { minute in
                        Text(String(format: "%02d", minute)).tag(minute)
                    }
                }
                .frame(width: 44)
                
                Text(":")
                
                Picker("秒", selection: $viewModel.selectedSecond) {
                    ForEach(0..<60) { second in
                        Text(String(format: "%02d", second)).tag(second)
                    }
                }
                .frame(width: 44)
            }
            .monospacedDigit()
        }
        
        Button(action: {
            onTimeSelected(viewModel.totalSelectedTime())
            timerViewModel.timerState = .running
        }, label: {
            Text("開始")
        })
        .disabled(viewModel.selectedHour == 0 && viewModel.selectedMinute == 0 && viewModel.selectedSecond == 0)
    }
}

#Preview {
    EndTimePickerView(viewModel: EndTimePickerViewModel(), timerViewModel: CountDownTimerViewModel()) { _ in }
}
