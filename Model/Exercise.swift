/*
Abstract:
A representation of an exercise.
*/

import Foundation
import SwiftUI

struct Exercise: Codable, Hashable, Identifiable {
    var id: UUID
    var name: String
    var imageName: String
    var notes: String

    var image: Image {
        Image(imageName)
    }
    
    static var formatter: MassFormatter {
            let formatter = MassFormatter()
            formatter.unitStyle = .medium
            formatter.isForPersonMassUse = true
            return formatter
        }
}
