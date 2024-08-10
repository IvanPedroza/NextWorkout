import SwiftUI

struct WorkoutDetail: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode  // Add this line
    var workout: Workout

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Last Session")
                    .font(.title)
                Spacer()
            }

            Text("Muscle Group: \(workout.focus)")
                .font(.subheadline)

            Divider()

            Text("Notes")
                .font(.title3)
            Text(workout.notes)
                .padding(.bottom, 10)

            Divider()

            List {
                ForEach(workout.exercisesList) { exercise in
                    NavigationLink(destination: ExerciseDetail(exercise: exercise, workoutId: workout.id)) {
                        ExerciseRow(exercise: exercise)
                            .padding(0)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .edgesIgnoringSafeArea(.horizontal)
            .navigationBarTitleDisplayMode(.inline)

            Button(action: completeWorkout) {
                Text("Complete Workout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            .padding(.horizontal)
        }
        .padding()
    }

    func completeWorkout() {
        modelData.completeCurrentWorkout()
        presentationMode.wrappedValue.dismiss()  // Dismiss the view and go back to WorkoutHome
    }
}

#Preview {
    let modelData = ModelData()
    return WorkoutDetail(workout: modelData.workouts[0])
        .environmentObject(modelData)
}
