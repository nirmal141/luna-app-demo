import Foundation

struct User: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var username: String = "" // Default for backward compatibility
    let imageName: String
    let relationship: RelationshipType
    var bio: String = ""
    var friendsCount: Int = 0
    var plansCount: Int = 0
    var savedCount: Int = 0
    var meetsCount: Int = 0
    var rating: Double = 0.0
    var university: String = "University"
    var interests: [String] = []
    
    enum RelationshipType {
        case friend
        case mutual
        case stranger
    }
}
