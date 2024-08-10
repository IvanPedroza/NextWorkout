//
//  WorkoutSchedule.swift
//  NextWorkout
//
//  Created by Ivan Pedroza on 7/31/24.
//

import Foundation


struct Schedule: Identifiable, Codable {
    var id: UUID
    var name: String
    var workouts: [Workout] = []
}


