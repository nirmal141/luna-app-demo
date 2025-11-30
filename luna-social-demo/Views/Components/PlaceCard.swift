import SwiftUI
import UIKit

struct PlaceCard: View {
    let place: Place
    let onInterestTapped: () -> Void
    let onInviteTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Hero Image Section
            ZStack(alignment: .topTrailing) {
                // Background Gradient/Image
                ZStack {
                    Theme.accentGradient
                    
                    Image(systemName: place.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .foregroundStyle(.white.opacity(0.3))
                        .offset(x: 20, y: 20)
                }
                .frame(height: 180)
                .clipped()
                
                // Glassmorphism Invite Button
                Button(action: onInviteTapped) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.ultraThinMaterial) // The "Frosted Glass" effect
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding(16)
            }
            
            // MARK: - Content Section
            VStack(alignment: .leading, spacing: 16) {
                
                // Title & Location
                VStack(alignment: .leading, spacing: 4) {
                    Text(place.name)
                        .font(.roundedTitle())
                        .foregroundStyle(Theme.text)
                    
                    Label(place.location, systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundStyle(Theme.secondaryText)
                }
                
                Divider()
                    .background(Color.white.opacity(0.1))
                
                // Footer: Social Proof + Action Button
                HStack(alignment: .center) {
                    if !place.interestedUsers.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("FRIENDS GOING")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(Theme.secondaryText)
                                .tracking(1) // Letter spacing
                            
                            AvatarStack(users: place.interestedUsers)
                        }
                    } else {
                        Text("Be the trendsetter")
                            .font(.caption)
                            .foregroundStyle(Theme.secondaryText)
                            .italic()
                    }
                    
                    Spacer()
                    
                    // The "Gradient" Action Button
                    Button(action: onInterestTapped) {
                        HStack(spacing: 6) {
                            Image(systemName: place.isUserInterested ? "checkmark" : "plus")
                                .font(.system(size: 14, weight: .bold))
                            
                            Text(place.isUserInterested ? "Going" : "Join")
                                .font(.roundedSubheadline())
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(
                            // Dynamic Gradient based on state
                            Group {
                                if place.isUserInterested {
                                    Theme.joinGradient
                                } else {
                                    Color.white.opacity(0.1)
                                }
                            }
                        )
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(.white.opacity(0.1), lineWidth: 1)
                        )
                        .shadow(color: place.isUserInterested ? Color.green.opacity(0.4) : Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                    }
                }
            }
            .padding(20)
            .background(Theme.surface)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
}
