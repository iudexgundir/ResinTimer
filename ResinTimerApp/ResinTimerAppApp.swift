//
//  ResinTimerAppApp.swift
//  ResinTimerApp
//
//  Created by Эрхаан Говоров on 09.04.2022.
//

import SwiftUI

@main
struct ResinTimerAppApp: App {
    // MARK: Since
    @StateObject var resinTimerModel: ResinTimerModel = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(resinTimerModel)
                }
        }
    }

