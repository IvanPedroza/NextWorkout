//
//  ExerciseLog.swift
//  NextWorkout
//
//  Created by Ivan Pedroza on 8/7/24.
//

import Foundation

struct ExerciseLog: Identifiable, Codable {
    var id: UUID
    var exerciseId: UUID
    var workoutId: UUID
    var date: Date
    var sets: [SetDetail]
}
