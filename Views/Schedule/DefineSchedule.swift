//import SwiftUI
//
//struct DefineSchedule: View {
//    @EnvironmentObject var modelData: ModelData
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach($modelData.workouts.indices) { $dailyWorkout in
//                    NavigationLink(destination: DailyWorkoutDetail(dailyWorkout: $dailyWorkout)) {
//                        VStack(alignment: .leading) {
//                            Text(dailyWorkout.dayName)
//                                .font(.headline)
//                            Text(dailyWorkout.workouts.map { $0.name }.joined(separator: ", "))
//                                .font(.subheadline)
//                        }
//                    }
//                }
//                .onDelete { indexSet in
//                    modelData.schedules.workouts.remove(atOffsets: indexSet)
//                }
//            }
//            .navigationTitle("Define Schedule")
//            .toolbar {
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        let newDailyWorkout = Workout(dayName: "", workouts: [])
//                        modelData.workoutSchedule.dailyWorkouts.append(newDailyWorkout)
//                        if let newIndex = modelData.workoutSchedule.dailyWorkouts.firstIndex(of: newDailyWorkout) {
//                            modelData.selectedDailyWorkout = IdentifiableIndex(id: newIndex)
//                        }
//                    }) {
//                        Text("Add Training Day")
//                    }
//
//                    Button(action: {
//                        modelData.saveSchedule()
//                    }) {
//                        Text("Save")
//                    }
//                }
//            }
//        }
//    }
//}
