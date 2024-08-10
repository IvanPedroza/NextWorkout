import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .workouts
    @EnvironmentObject var modelData: ModelData
    @State private var showingChangeSchedule = false

    enum Tab {
        case workouts
        case schedule
        case list
    }

    var body: some View {
        TabView(selection: $selection) {
            
            WorkoutHome()
                .tabItem {
                    Label("Workouts", systemImage: "house")
                }
                .tag(Tab.workouts)
            
//
//            ExerciseList()
//                .tabItem {
//                    Label("Exercises", systemImage: "figure.strengthtraining.traditional")
//                }
//                .tag(Tab.list)

            

//            NextWorkoutCard()
//                .tabItem {
//                    Label("Next Workout", systemImage: "star.fill")
//                }
//                .tag(Tab.schedule)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ModelData())
}
