//
//  WorkoutRow.swift
//  NextWorkout
//
//  Created by Ivan Pedroza on 7/30/24.
//
import SwiftUI

struct WorkoutRow: View {
    var categoryName: String
    var items: [Workout]
    @State private var selectedWorkout: Workout?

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items, id: \.name) { workout in
                        Button(action: {
                            selectedWorkout = workout
                        }) {
                            WorkoutItem(workout: workout)
                                .onAppear {
                                    print("Workout Name: \(workout.name), Workout ID: \(workout.id), Category: \(workout.category.rawValue)")
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(height: 185)
        }
        .background(
            NavigationLink(
                destination: selectedWorkout.map { WorkoutDetail(workout: $0) },
                isActive: .constant(selectedWorkout != nil),
                label: { EmptyView() }
            )
            .hidden()
        )
    }
}



#Preview {
    let modelData = ModelData()
    let workouts = modelData.workouts
    return WorkoutRow(
        categoryName: workouts[0].category.rawValue,
        items: Array(workouts.prefix(4))
    )
        .environmentObject(modelData)
}
