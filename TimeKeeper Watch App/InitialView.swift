//
//  InitialView.swift
//  TimeKeeper Watch App
//
//  Created by Ayana Kudo on 2024/08/16.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        VStack {
            Image(systemName:"timer")
                .font(.system(size: 50))
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    InitialView()
}
