//
//  ResinTimerAppApp.swift
//  ResinTimerApp
//
//  Created by Эрхаан Говоров on 09.04.2022.
//

import SwiftUI

@main
struct ResinTimerAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    print("applicationDidBecomeActive")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("applicationWillEnterForeground")
                }
        }
    }
}
