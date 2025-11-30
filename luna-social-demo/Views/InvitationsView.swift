import SwiftUI

struct InvitationsView: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                // Header
                Text("Invitations")
                    .font(Theme.headerFont(size: 32))
                    .foregroundStyle(Theme.text)
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Theme.secondaryText)
                    
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text("Search conversations...")
                                .foregroundStyle(Theme.secondaryText)
                        }
                        TextField("", text: $searchText)
                            .foregroundStyle(Theme.text)
                            .accentColor(Theme.accentColor)
                    }
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Theme.secondaryText)
                        }
                    }
                }
                .padding(12)
                .background(Theme.surface)
                .clipShape(Capsule())
                .padding(.horizontal, 24)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        // MARK: - Received Requests
                        VStack(alignment: .leading, spacing: 16) {
                            Text("RECEIVED")
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundStyle(Theme.secondaryText)
                                .tracking(1)
                                .padding(.horizontal, 24)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ReceivedRequestCard(
                                        user: User(name: "Mike", imageName: "vibrant-portrait-person-bright-environment", relationship: .mutual),
                                        placeName: "Central Rock Gym",
                                        time: "1h ago"
                                    )
                                    
                                    ReceivedRequestCard(
                                        user: User(name: "Sarah", imageName: "beautiful-woman-looking-out-ocean-round-window", relationship: .friend),
                                        placeName: "The Blue Note",
                                        time: "2h ago"
                                    )
                                }
                                .padding(.horizontal, 24)
                            }
                        }
                        
                        // MARK: - Sent Requests
                        VStack(alignment: .leading, spacing: 16) {
                            Text("SENT")
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundStyle(Theme.secondaryText)
                                .tracking(1)
                                .padding(.horizontal, 24)
                            
                            VStack(spacing: 0) {
                                SentRequestRow(
                                    user: User(name: "Jessica", imageName: "androgynous-avatar-non-binary-queer-person", relationship: .friend),
                                    placeName: "Hidden Ramen",
                                    status: "Pending"
                                )
                                Divider().background(Color.white.opacity(0.1)).padding(.leading, 76)
                                
                                SentRequestRow(
                                    user: User(name: "Tom", imageName: "vibrant-portrait-person-bright-environment", relationship: .stranger),
                                    placeName: "Rooftop Cinema",
                                    status: "Accepted",
                                    isAccepted: true
                                )
                            }
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

// MARK: - Components

struct ReceivedRequestCard: View {
    let user: User
    let placeName: String
    let time: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Image(user.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                        .foregroundStyle(Theme.text)
                    Text(time)
                        .font(.caption)
                        .foregroundStyle(Theme.secondaryText)
                }
                
                Spacer()
            }
            
            // Content
            Text("Invited you to **\(placeName)**")
                .font(.subheadline)
                .foregroundStyle(Theme.text)
                .lineLimit(2)
            
            // Actions
            HStack(spacing: 12) {
                Button {
                    // Accept action
                } label: {
                    Text("Accept")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Theme.yellow)
                        .foregroundStyle(.black)
                        .clipShape(Capsule())
                }
                
                Button {
                    // Decline action
                } label: {
                    Text("Decline")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.1))
                        .foregroundStyle(Theme.text)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(20)
        .frame(width: 280)
        .background(Theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

struct SentRequestRow: View {
    let user: User
    let placeName: String
    let status: String
    var isAccepted: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            // Avatar
            Image(user.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white.opacity(0.1), lineWidth: 1))
                .foregroundStyle(Theme.secondaryText)
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                    .foregroundStyle(Theme.text)
                Text("Invited to \(placeName)")
                    .font(.subheadline)
                    .foregroundStyle(Theme.secondaryText)
            }
            
            Spacer()
            
            // Status
            Text(status)
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(isAccepted ? Theme.yellow.opacity(0.2) : Color.white.opacity(0.05))
                .foregroundStyle(isAccepted ? Theme.yellow : Theme.secondaryText)
                .clipShape(Capsule())
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
    }
}

#Preview {
    InvitationsView()
}
