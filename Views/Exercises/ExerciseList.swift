import SwiftUI

struct ExerciseList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingAddExercise = false

    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.exercises) { exercise in
                    ExerciseRow(exercise: exercise)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .padding(.leading, 15)
                }
                .onDelete(perform: deleteExercise)
            }
            .listStyle(PlainListStyle()) // Use PlainListStyle for better control over the appearance
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddExercise = true
                    }) {
                        Label("Add Exercise", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddExercise) {
                AddExercise()
                    .environmentObject(modelData)
            }
        }
    }

    private func deleteExercise(at offsets: IndexSet) {
        modelData.exercises.remove(atOffsets: offsets)
        modelData.saveExercises()
    }
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList()
            .environmentObject(ModelData())
    }
}
