import SwiftUI

struct WorkoutHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    @State private var showingChangeSchedule = false

    var body: some View {
        NavigationView {
            List {
                // Bind the next workout to the card
                if let workout = modelData.getNextWorkout() {
                    NextWorkoutCard(nextWorkout: .constant(workout))
                        .background(
                            NavigationLink("", destination: WorkoutDetail(workout: workout))
                                .opacity(0)
                        )
                        .listRowInsets(EdgeInsets())
                        .padding(.trailing, -20)
                } else {
                    Text("No upcoming workouts found.")
                        .font(.headline)
                        .padding()
                }

                // Display workout categories
                ForEach(Category.allCases, id: \.self) { category in
                    let workoutsForCategory = modelData.workouts.filter { $0.category == category }
                    
                    if !workoutsForCategory.isEmpty {
                        Section(header: Text(category.rawValue)
                                    .font(.headline)
                                    .padding(.leading, 15)
                                    .padding(.top, 5)) {
                            WorkoutRow(categoryName: category.rawValue, items: workoutsForCategory)
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Welcome")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showingProfile.toggle()
                    } label: {
                        Label("User Profile", systemImage: "person.crop.circle")
                    }

                    Button {
                        showingChangeSchedule.toggle()
                    } label: {
                        Label("Change Schedule", systemImage: "calendar")
                    }
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData)
            }
            .sheet(isPresented: $showingChangeSchedule) {
                ChangeScheduleView()
                    .environmentObject(modelData)
            }
        }
        .onAppear {
            modelData.loadCurrentSchedule()
        }
    }
}




#Preview {
    WorkoutHome()
        .environmentObject(ModelData())
}
