import Foundation
import Combine
import SwiftUI

class ModelData: ObservableObject {
    @Published var exercises: [Exercise] = load("exercises.json")
    @Published var workouts: [Workout] = load("workouts.json")
    @Published var schedules: [Schedule] = load("schedules.json")
    @Published var profile: Profile = load("profiles.json")
    @Published var exerciseLogs: [ExerciseLog] = []
    @Published var currentSchedule: Schedule? {
        didSet {
            saveCurrentSchedule()
        }
    }
    @Published var currentWorkoutIndex: Int = 0
    @Published var completedWorkouts: [UUID] = []

    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    init() {
        loadCurrentSchedule()
        loadCompletedWorkouts()
        if currentSchedule == nil {
            currentSchedule = schedules.first
        }
        updateNextWorkoutIndex()
    }
    
    func getNextWorkouts(count: Int) -> [Workout]? {
        guard let schedule = currentSchedule else { return nil }
        if schedule.workouts.isEmpty { return nil }

//        print("Current Workout Index: \(currentWorkoutIndex)")
//        print("Total Workouts in Schedule: \(schedule.workouts.count)")

        var nextWorkouts: [Workout] = []
        for i in 0..<count {
            let index = (currentWorkoutIndex + i) % schedule.workouts.count
            let workout = schedule.workouts[index]
//            print("Fetching workout at index \(index): \(workout.name)")
            nextWorkouts.append(workout)
        }

        return nextWorkouts
    }

    

    func saveExercises() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(exercises) {
            let url = ModelData.documentsDirectory.appendingPathComponent("exercises.json")
            do {
                try encoded.write(to: url)
            } catch {
                print("Failed to save exercises: \(error.localizedDescription)")
            }
        }
    }

    func saveCurrentSchedule() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(currentSchedule) {
            let url = ModelData.documentsDirectory.appendingPathComponent("schedules.json")
            do {
                try encoded.write(to: url)
            } catch {
                print("Failed to save current schedule: \(error.localizedDescription)")
            }
        }
    }

    func loadCurrentSchedule() {
        print(ModelData.documentsDirectory)
        let url = ModelData.documentsDirectory.appendingPathComponent("schedules.json")
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            currentSchedule = try? decoder.decode(Schedule.self, from: data)
        }
    }

    func loadCompletedWorkouts() {
        let url = ModelData.documentsDirectory.appendingPathComponent("completedWorkouts.json")
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            completedWorkouts = (try? decoder.decode([UUID].self, from: data)) ?? []
        }
    }

    func saveCompletedWorkouts() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(completedWorkouts) {
            let url = ModelData.documentsDirectory.appendingPathComponent("completedWorkouts.json")
            do {
                try encoded.write(to: url)
            } catch {
                print("Failed to save completed workouts: \(error.localizedDescription)")
            }
        }
    }

    func getNextWorkout() -> Workout? {
        guard let schedule = currentSchedule else { return nil }
        if schedule.workouts.isEmpty {
            return nil
        }
        return schedule.workouts[currentWorkoutIndex]
    }

    func completeCurrentWorkout() {
        guard let schedule = currentSchedule else { return }
        let completedWorkout = schedule.workouts[currentWorkoutIndex]
        completedWorkouts.append(completedWorkout.id)
        currentWorkoutIndex = (currentWorkoutIndex + 1) % schedule.workouts.count
        saveCompletedWorkouts()
        saveCurrentSchedule()
    }

    func updateNextWorkoutIndex() {
        guard let schedule = currentSchedule else { return }
        for workout in schedule.workouts {
            if completedWorkouts.contains(workout.id) {
                currentWorkoutIndex = (currentWorkoutIndex + 1) % schedule.workouts.count
            }
        }
    }

    func getLastSession(for exerciseId: UUID, workoutId: UUID) -> [SetDetail]? {
        let lastLog = exerciseLogs.filter { $0.exerciseId == exerciseId && $0.workoutId == workoutId }.last
        return lastLog?.sets
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    var data: Data

    // First, try to load from the app bundle
    if let file = Bundle.main.url(forResource: filename, withExtension: nil) {
        do {
            data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to load \(filename) from main bundle, trying documents directory.")
        }
    } else {
        print("File \(filename) not found in the bundle, trying documents directory.")
    }

    // Fallback to loading from the documents directory
    let url = ModelData.documentsDirectory.appendingPathComponent(filename)
    if FileManager.default.fileExists(atPath: url.path) {
        do {
            data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't load \(filename) from documents directory:\n\(error)")
        }
    }

    fatalError("Couldn't find \(filename) in either the bundle or documents directory.")
}


//func load<T: Decodable>(_ filename: String) -> T {
//    let data: Data
//
//    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//        else {
//            fatalError("Couldn't find \(filename) in main bundle.")
//    }
//
//    do {
//        data = try Data(contentsOf: file)
//    } catch {
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//    }
//}
