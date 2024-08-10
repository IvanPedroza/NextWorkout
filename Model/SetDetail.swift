import Foundation

struct SetDetail: Identifiable, Codable, Equatable {
    var id: UUID
    var setNumber: Int
    var weight: Double
    var reps: Int

    static func == (lhs: SetDetail, rhs: SetDetail) -> Bool {
        lhs.id == rhs.id && lhs.setNumber == rhs.setNumber && lhs.weight == rhs.weight && lhs.reps == rhs.reps
    }
}
