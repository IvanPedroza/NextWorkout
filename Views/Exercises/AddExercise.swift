import SwiftUI

struct AddExercise: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var notes = ""
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    @State private var imageName = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    TextField("Name", text: $name)
                    TextField("Notes", text: $notes)
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("Select Image")
                    }
                }
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        addExercise()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }
        }
    }

    private func addExercise() {
        guard let image = image else { return }
        saveImage(image: image)
        let newExercise = Exercise(id: UUID(), name: name, imageName: imageName, notes: notes)
        modelData.exercises.append(newExercise)
        modelData.saveExercises()
    }

    private func saveImage(image: UIImage) {
        let imageData = image.jpegData(compressionQuality: 0.8)
        let uuid = UUID().uuidString
        imageName = uuid + ".jpg"

        let fileURL = ModelData.documentsDirectory.appendingPathComponent(imageName)
        do {
            try imageData?.write(to: fileURL)
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExercise()
            .environmentObject(ModelData())
    }
}
