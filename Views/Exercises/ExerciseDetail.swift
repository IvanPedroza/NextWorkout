import SwiftUI

struct ExerciseDetail: View {
    @EnvironmentObject var modelData: ModelData
    var exercise: Exercise
    var workoutId: UUID

    @State private var sets: [SetDetail] = []
    @State private var showingAlert = false
    @State private var lastSession: [SetDetail] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                
                // Current Workout Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Current Session")
                        .font(.title2)

                    List {
                        ForEach($sets) { $set in
                            HStack {
                                Text("Set \(set.setNumber)")
                                    .frame(minWidth: 40, alignment: .leading)

                                Spacer()

                                Picker("Weight", selection: $set.weight) {
                                    ForEach(Array(stride(from: 0.0, to: 200.0, by: 2.5)), id: \.self) { weight in
                                        Text("\(weight, specifier: "%.1f") ").tag(weight)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(minWidth: 100, alignment: .leading)

                                Spacer()

                                Picker("Reps", selection: $set.reps) {
                                    ForEach(0..<50, id: \.self) { reps in
                                        Text("\(reps) reps").tag(reps)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(minWidth: 80, alignment: .leading)

                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .listRowInsets(EdgeInsets())
                            .swipeActions {
                                Button(role: .destructive) {
                                    if let index = sets.firstIndex(where: { $0.id == set.id }) {
                                        sets.remove(at: index)
                                        updateSetNumbers()
                                        saveCurrentSession()
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: CGFloat(sets.count) * 50 + 50)

                    Button(action: {
                        let newSet = SetDetail(id: UUID(), setNumber: sets.count + 1, weight: 0, reps: 0)
                        sets.append(newSet)
                        saveCurrentSession()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Set")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .background(Color(UIColor.systemGroupedBackground))
                    .cornerRadius(10)
                    .padding(.vertical)
                }
                .padding()
                
                Divider()

                // Previous Session Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Previous Session")
                        .font(.title2)

                    if !lastSession.isEmpty {
                        ForEach(lastSession, id: \.id) { set in
                            HStack {
                                Text("Set \(set.setNumber):")
                                Spacer()
                                Text("\(Exercise.formatter.string(fromValue: set.weight, unit: .pound)) for \(set.reps) reps")
                            }
                        }
                    } else {
                        Text("No previous session data.")
                    }
                }
                .padding()
                
                // Complete Exercise Button
                Button(action: completeExercise) {
                    Text("Complete Exercise")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ProminentButtonStyle())
                .padding(.top, 10)
                .padding(.horizontal)
            }
        }
        .onAppear(perform: loadCurrentSession)
        .navigationTitle(exercise.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Exercise Completed"), message: Text("Your exercise data has been saved."), dismissButton: .default(Text("OK")))
        }
    }
    
    func updateSetNumbers() {
        for index in sets.indices {
            sets[index].setNumber = index + 1
        }
    }

    func saveCurrentSession() {
        let encoder = JSONEncoder()
        if let encodedSets = try? encoder.encode(sets) {
            let url = ModelData.documentsDirectory.appendingPathComponent("currentSession_\(exercise.id).json")
            try? encodedSets.write(to: url)
        }
    }

    func loadCurrentSession() {
        let url = ModelData.documentsDirectory.appendingPathComponent("currentSession_\(exercise.id).json")
        if let data = try? Data(contentsOf: url),
           let decodedSets = try? JSONDecoder().decode([SetDetail].self, from: data) {
            sets = decodedSets
        } else {
            sets = (1...3).map { SetDetail(id: UUID(), setNumber: $0, weight: 0, reps: 0) }
        }
        lastSession = modelData.getLastSession(for: exercise.id, workoutId: workoutId) ?? []
    }

    func completeExercise() {
        let newLog = ExerciseLog(
            id: UUID(),
            exerciseId: exercise.id,
            workoutId: workoutId,
            date: Date(),
            sets: sets
        )
        modelData.exerciseLogs.append(newLog)
        modelData.saveExercises()

        showingAlert = true
        sets = (1...3).map { SetDetail(id: UUID(), setNumber: $0, weight: 0, reps: 0) }
        saveCurrentSession()
        lastSession = sets
    }
}


struct ExerciseDetail_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        ExerciseDetail(exercise: modelData.exercises[0], workoutId: UUID())
            .environmentObject(modelData)
    }
}
