import SwiftUI

struct BottomTabBarView: View {
    @State private var selectedTab: Tab = .home
    @Namespace private var animation
    
    // Hide default tab bar
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Main Content
            TabView(selection: $selectedTab) {
                ReelsView()
                    .tag(Tab.home)

                PeopleView()
                    .tag(Tab.people)

                InvitationsView()
                    .tag(Tab.messages)

                ProfileView()
                    .tag(Tab.profile)
            }
            
            // Custom Floating Tab Bar
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Spacer()
                    TabBarItem(
                        tab: tab,
                        selectedTab: $selectedTab,
                        namespace: animation,
                        badgeCount: tab == .messages ? 3 : 0
                    )
                    Spacer()
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 24)
            .padding(.bottom, 0)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TabBarItem: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    var namespace: Namespace.ID
    var badgeCount: Int = 0
    
    var isSelected: Bool {
        selectedTab == tab
    }
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: isSelected ? tab.iconFill : tab.icon)
                        .font(.system(size: 24))
                        .scaleEffect(isSelected ? 1.2 : 1.0)
                    
                    if badgeCount > 0 {
                        Text("\(badgeCount)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.black)
                            .frame(width: 16, height: 16)
                            .background(Theme.yellow)
                            .clipShape(Circle())
                            .offset(x: 10, y: -8)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 1.5)
                                    .offset(x: 10, y: -8)
                            )
                    }
                }
                
                if isSelected {
                    Circle()
                        .fill(Theme.yellow)
                        .frame(width: 4, height: 4)
                        .matchedGeometryEffect(id: "tab_dot", in: namespace)
                }
            }
            .frame(height: 44)
            .foregroundStyle(isSelected ? Theme.yellow : Color.white.opacity(0.5))
        }
    }
}

enum Tab: String, CaseIterable {
    case home, people, messages, profile
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .people: return "person.2"
        case .messages: return "message"
        case .profile: return "person"
        }
    }
    
    var iconFill: String {
        switch self {
        case .home: return "house.fill"
        case .people: return "person.2.fill"
        case .messages: return "message.fill"
        case .profile: return "person.fill"
        }
    }
}

// MARK: - Placeholder Tab Screens

private struct CreateView: View {
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 48))
                    .foregroundStyle(Theme.secondaryText)
                Text("Create a Plan")
                    .font(.roundedTitle())
                    .foregroundStyle(Theme.text)
                Text("Start a hangout, invite friends, and set the vibe.")
                    .foregroundStyle(Theme.secondaryText)
                Button {
                    // Hook up to your creation flow
                } label: {
                    Text("Start a Plan")
                        .font(.roundedHeadline())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Theme.accentGradient)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 8)
            }
            .padding()
        }
    }
}



#Preview {
    BottomTabBarView()
}
