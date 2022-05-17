//
//  ResinTimerModel.swift
//  ResinTimerApp
//
//  Created by Эрхаан Говоров on 16.05.2022.
//

import SwiftUI

class ResinTimerModel: NSObject, ObservableObject {
    // MARK: Timer Properties
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var seconds: Int = 0
}

