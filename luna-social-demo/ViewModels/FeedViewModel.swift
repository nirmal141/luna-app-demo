import SwiftUI
import UIKit // Added to ensure haptics work
import Combine

@MainActor
class FeedViewModel: ObservableObject {
    @Published var places: [Place] = []
    
    init() {
        loadPlaces()
    }
    
    func loadPlaces() {
        self.places = MockDataService.shared.getPlaces()
    }
    
    func toggleInterest(for place: Place) {
        if let index = places.firstIndex(where: { $0.id == place.id }) {
            // Haptic Feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare() // Good practice to prepare before firing
            generator.impactOccurred()
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                places[index].isUserInterested.toggle()
            }
        }
    }
    
    func inviteFriends(to place: Place) {
        print("Invite flow for \(place.name)")
    }
}
