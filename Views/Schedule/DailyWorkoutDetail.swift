//import SwiftUI
//
//struct DailyWorkoutDetail: View {
//    @Binding var workout: Workout
//    @State private var newWorkoutName = ""
//    @State private var selectedCategory: Category = .strength
//    @EnvironmentObject var modelData: ModelData
//
//    var body: some View {
//        Form {
//            Section(header: Text("Day Name")) {
//                TextField("Day Name", text: $workout.name)
//            }
//            
//            Section(header: Text("Workouts")) {
//                ForEach($workout.workouts) { $workout in
//                    Text(workout.name)
//                }
//                .onDelete { indexSet in
//                    workout.workouts.remove(atOffsets: indexSet)
//                }
//
//                HStack {
//                    TextField("New Workout", text: $newWorkoutName)
//                    Picker("Category", selection: $selectedCategory) {
//                        ForEach(Category.allCases, id: \.self) { category in
//                            Text(category.rawValue).tag(category)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//
//                    Button(action: addWorkout) {
//                        Image(systemName: "plus.circle.fill")
//                    }
//                }
//            }
//        }
//        .navigationTitle(workout.dayName)
//    }
//
//    func addWorkout() {
//        guard !newWorkoutName.isEmpty else { return }
//
//        let newWorkout = Workout(
//            id: 1000,
//            name: newWorkoutName,
//            exercisesList: [],
//            muscleGroup: "",
//            notes: "",
//            category: selectedCategory,
//            imageName: "twinlakes"
//        )
//        dailyWorkout.workouts.append(newWorkout)
//        newWorkoutName = ""
//    }
//}
//
//
//
