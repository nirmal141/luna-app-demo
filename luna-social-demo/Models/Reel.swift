import Foundation

struct Reel: Identifiable {
    let id = UUID()
    let videoUrl: URL
    let poster: User
    let place: Place
    let description: String
    var likes: Int
    var comments: Int
    var isLiked: Bool = false
}
