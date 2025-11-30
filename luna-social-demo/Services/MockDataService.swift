import Foundation

class MockDataService {
    static let shared = MockDataService()
    
    func getCurrentUser() -> User {
        return User(
            name: "Sarah Jenkins",
            username: "@sarah_j",
            imageName: "beautiful-woman-looking-out-ocean-round-window",
            relationship: .friend, // Self
            bio: "Adventure seeker 🌍 | Coffee enthusiast ☕️ | Always down for a plan 📅",
            friendsCount: 1240,
            plansCount: 45,
            savedCount: 12,
            meetsCount: 28,
            rating: 4.9
        )
    }

    func getPlaces() -> [Place] {
        let u1 = User(name: "Sarah", username: "@sarah_j", imageName: "beautiful-woman-looking-out-ocean-round-window", relationship: .friend)
        let u2 = User(name: "Mike", username: "@mike_moves", imageName: "vibrant-portrait-person-bright-environment", relationship: .mutual)
        let u3 = User(name: "Jessica", username: "@jess_codes", imageName: "androgynous-avatar-non-binary-queer-person", relationship: .friend)
        let u4 = User(name: "Tom", username: "@tom_travels", imageName: "vibrant-portrait-person-bright-environment", relationship: .stranger)

        return [
            Place(name: "The Blue Note",
                  location: "Greenwich Village • 0.4 mi",
                  imageName: "music.mic",
                  interestedUsers: [u1, u2, u4]),
            Place(name: "Central Rock Gym",
                  location: "Manhattan • 1.2 mi",
                  imageName: "figure.climbing",
                  interestedUsers: [u3, u1]),
            Place(name: "Hidden Ramen",
                  location: "Brooklyn • 3.5 mi",
                  imageName: "fork.knife",
                  interestedUsers: []),
            Place(name: "Rooftop Cinema",
                  location: "Seaport • 0.8 mi",
                  imageName: "popcorn.fill",
                  interestedUsers: [u2, u3, u4, u1])
        ]
    }
    func getReels() -> [Reel] {
        let u1 = User(name: "Sarah", username: "@sarah_j", imageName: "beautiful-woman-looking-out-ocean-round-window", relationship: .friend)
        let u2 = User(name: "Mike", username: "@mike_moves", imageName: "vibrant-portrait-person-bright-environment", relationship: .mutual)
        let u3 = User(name: "Jessica", username: "@jess_codes", imageName: "androgynous-avatar-non-binary-queer-person", relationship: .friend)
        let u4 = User(name: "Tom", username: "@tom_travels", imageName: "vibrant-portrait-person-bright-environment", relationship: .stranger)
        
        let p1 = Place(name: "The Blue Note", location: "Greenwich Village", imageName: "music.mic", interestedUsers: [u1, u2])
        let p2 = Place(name: "Central Rock Gym", location: "Manhattan", imageName: "figure.climbing", interestedUsers: [u3])
        let p3 = Place(name: "Hidden Ramen", location: "Brooklyn", imageName: "fork.knife", interestedUsers: [])
        let p4 = Place(name: "Rooftop Cinema", location: "Seaport", imageName: "popcorn.fill", interestedUsers: [u2, u4])
        
        // Helper to get URL or a placeholder
        func videoUrl(for name: String) -> URL {
            if let url = Bundle.main.url(forResource: name, withExtension: "mp4") {
                return url
            }
            // Fallback to a dummy URL if file not found to prevent crash
            return URL(string: "https://example.com/placeholder.mp4")!
        }

        return [
            Reel(videoUrl: videoUrl(for: "5585336-uhd_2160_4096_25fps"), poster: u1, place: p1, description: "Jazz night vibes 🎷", likes: 124, comments: 12),
            Reel(videoUrl: videoUrl(for: "6602215-hd_1080_1920_30fps"), poster: u2, place: p2, description: "Crushing the V5 project! 💪", likes: 89, comments: 5),
            Reel(videoUrl: videoUrl(for: "7339414-uhd_2160_4096_25fps"), poster: u3, place: p3, description: "Best ramen in town 🍜", likes: 256, comments: 34),
            Reel(videoUrl: videoUrl(for: "8164420-uhd_2160_4096_25fps"), poster: u4, place: p4, description: "Movie night under the stars ✨", likes: 45, comments: 2),
            Reel(videoUrl: videoUrl(for: "13736702-uhd_2160_3840_24fps"), poster: u1, place: p1, description: "Encore! 👏", likes: 312, comments: 45)
        ]
    }
    
    func getPeople() -> [User] {
        return [
            User(
                name: "Julia",
                username: "@julia_styles",
                imageName: "beautiful-woman-looking-out-ocean-round-window", // Reusing existing asset for demo
                relationship: .stranger,
                bio: "I enjoy classical concerts, auctions, pickleball, baseball...",
                university: "Northeastern",
                interests: ["Concerts", "Auctions", "Pickleball"]
            ),
            User(
                name: "Liam",
                username: "@liam_lens",
                imageName: "vibrant-portrait-person-bright-environment",
                relationship: .stranger,
                bio: "Photography enthusiast capturing life one frame at a time. 📸",
                university: "NYU",
                interests: ["Photography", "Travel", "Coffee"]
            ),
            User(
                name: "Sophia",
                username: "@sophia_art",
                imageName: "androgynous-avatar-non-binary-queer-person",
                relationship: .stranger,
                bio: "Art student living in colors. Let's visit a gallery! 🎨",
                university: "Parsons",
                interests: ["Art", "Design", "Fashion"]
            ),
            User(
                name: "Ethan",
                username: "@ethan_eats",
                imageName: "vibrant-portrait-person-bright-environment",
                relationship: .stranger,
                bio: "Foodie on a mission to find the best burger in NYC. 🍔",
                university: "Columbia",
                interests: ["Food", "Cooking", "Hiking"]
            )
        ]
    }
}
