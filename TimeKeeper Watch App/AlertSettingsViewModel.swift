//
//  AlertSettingsViewModel.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/24.
//

import SwiftUI

class AlertSettingsViewModel: ObservableObject {
    @Published var alertThreshold: [TimeInterval] = [30]
    
    func deleteThreshold(at offsets: IndexSet) {
        alertThreshold.remove(atOffsets: offsets)
    }
    
    func addThreshold() {
        alertThreshold.append(60)
    }
}
