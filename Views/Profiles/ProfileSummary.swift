//import SwiftUI
//
//struct ProfileSummary: View {
//    @EnvironmentObject var modelData: ModelData
//    var profile: Profile
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 10) {
//                Text(profile.username)
//                    .bold()
//                    .font(.title)
//
//                Text("Notifications: \(profile.prefersNotifications ? "On" : "Off" )")
//                Text("Seasonal Photo: \(profile.seasonalPhoto.rawValue)")
//                Text("Goal Date: ") + Text(profile.goalDate, style: .date)
//
//                Divider()
//
//                VStack(alignment: .leading) {
//                    Text("Next Workout")
//                        .font(.headline)
//
//                    
//                }
//
//                Divider()
//
//                VStack(alignment: .leading) {
//                    Text("Workout History")
//                        .font(.headline)
//
////                    ForEach(modelData.workouts) { workout in
////                        HStack {
////                            Text(workout.name)
////                            Spacer()
////                            Text(workout.workoutDate)
////                        }
////                    }
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//#Preview {
//    ProfileSummary(profile: Profile.default)
//        .environmentObject(ModelData())
//}
