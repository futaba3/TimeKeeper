//
//  EndTimePickerView.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/16.
//

import SwiftUI

struct EndTimePickerView: View {
    @ObservedObject var viewModel: EndTimePickerViewModel
    
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
                .frame(width: 50)
                
                Text(":")
                
                Picker("分", selection: $viewModel.selectedMinute) {
                    ForEach(0..<60) { minute in
                        Text(String(format: "%02d", minute)).tag(minute)
                    }
                }
                .frame(width: 50)
                
                Text(":")
                
                Picker("秒", selection: $viewModel.selectedSecond) {
                    ForEach(0..<60) { second in
                        Text(String(format: "%02d", second)).tag(second)
                    }
                }
                .frame(width: 50)
            }
            .monospacedDigit()
        }
        
        Button(action: {
            onTimeSelected(viewModel.totalSelectedTime())
        }, label: {
            Text("開始")
        })
    }
}

#Preview {
    EndTimePickerView(viewModel: EndTimePickerViewModel()) { _ in }
}
