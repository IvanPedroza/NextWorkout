//
//  WorkoutItem.swift
//  NextWorkout
//
//  Created by Ivan Pedroza on 7/30/24.
//

import SwiftUI

struct WorkoutItem: View {
    var workout: Workout

    var body: some View {
        VStack(alignment: .leading) {
            workout.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(workout.name)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .padding(.leading, 15)
    }
}


#Preview {
    WorkoutItem(workout: ModelData().workouts[0])
}
