import SwiftUI

struct HomeFeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    @State private var selectedPlaceForInvite: Place?
    
    var body: some View {
        ZStack {
            // Background Color
            Theme.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Custom Header
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 8) {
                            // Date & Greeting
                            HStack(spacing: 6) {
                                Text("NOV 29")
                                    .font(.system(.caption2, design: .rounded))
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Theme.surface)
                                    .clipShape(Capsule())
                                    .foregroundStyle(Theme.secondaryText)
                                    .overlay(
                                        Capsule()
                                            .stroke(.white.opacity(0.1), lineWidth: 1)
                                    )
                                
                                Text("GOOD EVENING")
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Theme.secondaryText)
                                    .tracking(1)
                            }
                            
                            // Title
                            Text("What's the move?")
                                .font(.system(size: 36, weight: .black, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        
                        Spacer()
                        
                        // Premium Profile Placeholder
                        ZStack {
                            Circle()
                                .fill(Theme.surface)
                                .frame(width: 52, height: 52)
                                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                            
                            Circle()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [.white.opacity(0.1), .clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                                .frame(width: 52, height: 52)
                            
                            Image("beautiful-woman-looking-out-ocean-round-window")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 52, height: 52)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    
                    // Feed List
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.places) { place in
                            PlaceCard(
                                place: place,
                                onInterestTapped: {
                                    viewModel.toggleInterest(for: place)
                                },
                                onInviteTapped: {
                                    selectedPlaceForInvite = place
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100) // Extra padding for floating tab bar
                }
            }
        }
        .sheet(item: $selectedPlaceForInvite) { place in
            RestaurantInviteView(place: place)
        }
    }
}

#Preview {
    HomeFeedView()
}
