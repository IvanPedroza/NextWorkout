import Foundation
import SwiftUI

struct Workout: Identifiable, Hashable, Codable {

    var id: UUID
    var name: String
    var exercisesList: [Exercise]
    var focus: String
    var notes: String
    var category: Category
    var imageName: String

    var image: Image {
        Image(imageName)
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id
    }
}


enum Category: String, CaseIterable, Codable {
    case cardio = "Cardio"
    case strength = "Strength"
}



