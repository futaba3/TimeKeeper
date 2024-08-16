//
//  EndTimePickerViewModel.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/16.
//

import SwiftUI
import Combine

class EndTimePickerViewModel: ObservableObject {
    @Published var selectedHour: Int = 0
    @Published var selectedMinute: Int = 1
    @Published var selectedSecond: Int = 0
    
    func totalSelectedTime() -> TimeInterval {
        return TimeInterval(selectedHour * 3600 + selectedMinute * 60 + selectedSecond)
    }
}
