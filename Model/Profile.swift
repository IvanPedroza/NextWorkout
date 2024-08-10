/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A representation of user profile data.
*/

import Foundation

struct Profile: Codable, Hashable, Identifiable {
    var id: UUID
    var username: String
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.username == rhs.username
    }

}

