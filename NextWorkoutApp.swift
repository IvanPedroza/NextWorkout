//
//  NextWorkoutApp.swift
//  NextWorkout
//
//  Created by Ivan Pedroza on 7/30/24.
//

import SwiftUI

@main
struct NextWorkoutApp: App {
    @State private var modelData = ModelData()


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
