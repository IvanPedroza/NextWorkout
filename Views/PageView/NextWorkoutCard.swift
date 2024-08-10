import SwiftUI

struct NextWorkoutCard: View {
    @Binding var nextWorkout: Workout

    var body: some View {
        nextWorkout.image
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay {
                TextOverlay(workout: nextWorkout)
            }
    }
}

struct TextOverlay: View {
    var workout: Workout

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text("Next Workout")
                    .font(.title)
                    .bold()
                Text(workout.name)
                    .font(.subheadline)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}
