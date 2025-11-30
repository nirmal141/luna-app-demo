import SwiftUI

struct ProfileView: View {
    let user: User
    @State private var selectedTab: Int = 0
    
    init(user: User = MockDataService.shared.getCurrentUser()) {
        self.user = user
    }
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 32) {
                    // Header Title
                    HStack {
                        Text("My Profile")
                            .font(Theme.headerFont(size: 32))
                            .foregroundStyle(Theme.text)
                        Spacer()
                        Button {
                            // Settings
                        } label: {
                            Image(systemName: "gearshape")
                                .font(.title2)
                                .foregroundStyle(Theme.text)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    
                    // Profile Info
                    VStack(spacing: 20) {
                        // Image
                        ZStack {
                            Circle()
                                .stroke(Theme.yellow, lineWidth: 2)
                                .frame(width: 108, height: 108)
                            
                            Image(user.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        }
                        
                        // Name & Bio
                        VStack(spacing: 8) {
                            Text(user.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Theme.text)
                            
                            Text(user.username)
                                .font(.subheadline)
                                .foregroundStyle(Theme.secondaryText)
                            
                            Text(user.bio)
                                .font(.subheadline)
                                .foregroundStyle(Theme.text.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                                .lineLimit(3)
                                .lineSpacing(4)
                        }
                    }
                    
                    // Stats Row (Unified)
                    HStack(spacing: 0) {
                        StatView(value: "\(user.meetsCount)", label: "Meets")
                        Spacer()
                        Divider().frame(height: 30).background(Color.white.opacity(0.2))
                        Spacer()
                        StatView(value: "\(user.friendsCount)", label: "Friends")
                        Spacer()
                        Divider().frame(height: 30).background(Color.white.opacity(0.2))
                        Spacer()
                        StatView(value: "\(user.plansCount)", label: "Plans")
                        Spacer()
                        Divider().frame(height: 30).background(Color.white.opacity(0.2))
                        Spacer()
                        StatView(value: "\(user.savedCount)", label: "Saved")
                    }
                    .padding(.horizontal, 24)
                    
                    // Actions
                    HStack(spacing: 16) {
                        Button {
                            // Edit Profile
                        } label: {
                            Text("Edit Profile")
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Theme.yellow)
                                .foregroundStyle(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        
                        Button {
                            // Share Profile
                        } label: {
                            Text("Share")
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Theme.surface)
                                .foregroundStyle(Theme.text)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Content Tabs
                    VStack(spacing: 24) {
                        HStack(spacing: 0) {
                            TabButton(title: "Plans", isSelected: selectedTab == 0) {
                                withAnimation { selectedTab = 0 }
                            }
                            TabButton(title: "Reels", isSelected: selectedTab == 1) {
                                withAnimation { selectedTab = 1 }
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        // Grid Content
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(0..<6) { index in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Theme.surface)
                                    .aspectRatio(0.8, contentMode: .fit)
                                    .overlay(
                                        Image(systemName: selectedTab == 0 ? "calendar" : "play.fill")
                                            .font(.title2)
                                            .foregroundStyle(Theme.secondaryText.opacity(0.5))
                                    )
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .padding(.bottom, 120)
            }
        }
    }
}

// MARK: - Subviews



struct StatView: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Theme.text)
            Text(label)
                .font(.caption)
                .foregroundStyle(Theme.secondaryText)
        }
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(isSelected ? .bold : .medium)
                    .foregroundStyle(isSelected ? Theme.text : Theme.secondaryText)
                
                Rectangle()
                    .fill(isSelected ? Theme.yellow : Color.clear)
                    .frame(height: 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileView()
}
