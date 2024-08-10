//
//  WorkoutRow.swift
//  NextWorkout
//
//  Created by Ivan Pedroza on 7/30/24.
//

import SwiftUI

struct ExerciseRow: View {
    var exercise: Exercise

    var body: some View {
        HStack {
            loadImage(named: exercise.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            
            Text(exercise.name)
                .font(.headline)
            
            Spacer()
        }
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity, alignment: .leading) // Ensure the row touches the sides
    }

    private func loadImage(named imageName: String) -> Image {
        // Try to load the image from the documents directory
        let fileURL = ModelData.documentsDirectory.appendingPathComponent(imageName)
        if let uiImage = UIImage(contentsOfFile: fileURL.path) {
            return Image(uiImage: uiImage)
        }
        // Fall back to loading the image from the assets catalog
        else if UIImage(named: imageName) != nil {
            return Image(imageName)
        }
        // Return a default image if not found in both locations
        else {
            return Image(systemName: "photo")
        }
    }
}

struct ExerciseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRow(exercise: ModelData().exercises[0])
            .environmentObject(ModelData())
    }
}
