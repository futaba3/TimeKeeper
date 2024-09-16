//
//  AlertSettingsView.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/24.
//

import SwiftUI

struct AlertSettingsView: View {
    @ObservedObject var viewModel: CountDownTimerViewModel
    @ObservedObject var alertSettingsViewModel: AlertSettingsViewModel
    
    var body: some View {
        List {
            ForEach(alertSettingsViewModel.alertThreshold, id: \.self) { threshold in
                HStack {
                    Text("アラート1")
                    Spacer()
                    Text("\(Int(threshold))秒前")
                }
            }
            .onDelete(perform: alertSettingsViewModel.deleteThreshold)
            
            Button(action: {
                alertSettingsViewModel.addThreshold()
            }, label: {
                Text("アラートを追加")
            })
        }
    }
}

#Preview {
    AlertSettingsView(viewModel: CountDownTimerViewModel(), alertSettingsViewModel: AlertSettingsViewModel())
}
