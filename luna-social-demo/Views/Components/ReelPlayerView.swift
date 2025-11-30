import SwiftUI
import AVKit

struct ReelPlayerView: View {
    let reel: Reel
    @State private var player: AVPlayer?
    @State private var isMuted: Bool = false
    @State private var showInvite = false
    @State private var showInterestOptions = false
    let isUIHidden: Bool
    
    var body: some View {
        ZStack {
            // Video Player
            if let player = player {
                CustomVideoPlayer(player: player)
                    .disabled(true) // Disable default controls
                    .ignoresSafeArea()
                    .onAppear {
                        player.play()
                        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
                    .onDisappear {
                        player.pause()
                    }
            } else {
                Color.black.ignoresSafeArea()
                ProgressView()
            }
            
            // Gradient Overlay
            LinearGradient(
                colors: [.clear, .black.opacity(0.6)],
                startPoint: .center,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .opacity(isUIHidden ? 0 : 1)
            .animation(.easeInOut, value: isUIHidden)
            
            // UI Overlays
            ZStack(alignment: .bottomTrailing) {
                // Main UI Content
                VStack {
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        // Left Side: Info
                        VStack(alignment: .leading, spacing: 8) {
                            // Place Info
                            Button {
                                showInvite = true
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.caption)
                                    Text(reel.place.name)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.ultraThinMaterial)
                                .clipShape(Capsule())
                            }
                            .sheet(isPresented: $showInvite) {
                                RestaurantInviteView(place: reel.place)
                            }
                            
                            // Description
                            Text(reel.description)
                                .font(.body)
                                .lineLimit(2)
                                .shadow(radius: 2)
                            
                            // Friends Interested
                            if !reel.place.interestedUsers.isEmpty {
                                HStack(spacing: -8) {
                                    ForEach(reel.place.interestedUsers.prefix(3)) { user in
                                        Image(user.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 24, height: 24)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                            .background(Circle().fill(Color.gray))
                                    }
                                }
                                .padding(.leading, 4)
                                
                                Text("\(reel.place.interestedUsers.count) friends interested")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .shadow(radius: 2)
                                    
                            }
                            
                            // "I'm Interested" Button
                            Button {
                                showInterestOptions = true
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "star.fill")
                                    .font(.caption)
                                    Text("I'm Interested")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Theme.yellow)
                                .foregroundStyle(.black)
                                .clipShape(Capsule())
                            }
                            .padding(.top, 4)
                            .confirmationDialog("Interested?", isPresented: $showInterestOptions, titleVisibility: .visible) {
                                Button("Mark as Interested") {
                                    // Logic to mark as interested
                                }
                                Button("Invite Someone") {
                                    showInvite = true
                                }
                                Button("Cancel", role: .cancel) {}
                            } message: {
                                Text("Would you like to join or invite friends?")
                            }
                        }
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        // Right Side: Actions
                        VStack(spacing: 20) {
                            // Poster Profile
                            VStack(spacing: 0) {
                                Image(reel.poster.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.white, lineWidth: 2))
                                    .background(Circle().fill(Color.gray))
                                
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(Theme.accentColor)
                                    .background(Circle().fill(.white))
                                    .offset(y: -10)
                            }
                            
                            // Like
                            Button {
                                // Toggle like
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: "heart.fill")
                                        .font(.title)
                                        .foregroundStyle(reel.isLiked ? .red : .white)
                                        .shadow(radius: 2)
                                    Text("\(reel.likes)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .shadow(radius: 1)
                                }
                            }
                            .foregroundStyle(.white)
                            
                            // Comment
                            Button {
                                // Open comments
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: "bubble.right.fill")
                                        .font(.title)
                                        .shadow(radius: 2)
                                    Text("\(reel.comments)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .shadow(radius: 1)
                                }
                            }
                            .foregroundStyle(.white)
                            
                            // Invite (Paperplane)
                            Button {
                                showInvite = true
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: "paperplane.fill")
                                        .font(.title)
                                        .shadow(radius: 2)
                                    Text("Invite")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .shadow(radius: 1)
                                }
                            }
                            .foregroundStyle(.white)
                            
                            // More
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.title2)
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 150) // Space for tab bar
                }
                .opacity(isUIHidden ? 0 : 1)
                .animation(.easeInOut, value: isUIHidden)
            }
        }
        .onAppear {
            if player == nil {
                player = AVPlayer(url: reel.videoUrl)
            }
        }
    }
}
