import Foundation

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let imageName: String // SF Symbol for now
    let interestedUsers: [User]
    var isUserInterested: Bool = false
}
