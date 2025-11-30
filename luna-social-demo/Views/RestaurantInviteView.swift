import SwiftUI

struct RestaurantInviteView: View {
    let place: Place
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab: InviteTab = .friends
    @State private var selectedUserIds: Set<UUID> = []
    @State private var friends: [User] = []
    @State private var mutuals: [User] = []
    @State private var isSchedulingPresented = false
    
    enum InviteTab: String, CaseIterable {
        case friends = "Friends"
        case mutuals = "Mutuals"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // MARK: - Header
                    ZStack(alignment: .bottomLeading) {
                        Image(systemName: place.imageName) // Using system name as placeholder if real image not available
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                            .overlay(
                                LinearGradient(
                                    colors: [.clear, .black.opacity(0.8)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(place.name)
                                .font(Theme.headerFont(size: 32))
                                .foregroundStyle(.white)
                            
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundStyle(Theme.secondaryText)
                                Text(place.location)
                                    .font(.subheadline)
                                    .foregroundStyle(Theme.secondaryText)
                            }
                        }
                        .padding(20)
                    }
                    .frame(height: 200)
                    
                    // MARK: - Tabs
                    HStack(spacing: 0) {
                        ForEach(InviteTab.allCases, id: \.self) { tab in
                            Button {
                                withAnimation(.spring()) {
                                    selectedTab = tab
                                }
                            } label: {
                                VStack(spacing: 8) {
                                    Text(tab.rawValue)
                                        .font(.headline)
                                        .foregroundStyle(selectedTab == tab ? .white : .gray)
                                    
                                    Rectangle()
                                        .fill(selectedTab == tab ? Theme.yellow : Color.clear)
                                        .frame(height: 2)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.top, 16)
                    .background(Theme.surface)
                    
                    // MARK: - User List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            let usersToShow = selectedTab == .friends ? friends : mutuals
                            
                            ForEach(usersToShow) { user in
                                UserSelectionRow(user: user, isSelected: selectedUserIds.contains(user.id)) {
                                    toggleSelection(for: user)
                                }
                            }
                        }
                        .padding(20)
                    }
                    
                    // MARK: - Footer Action
                    VStack {
                        Button {
                            isSchedulingPresented = true
                        } label: {
                            Text("Next")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedUserIds.isEmpty ? Color.gray : Theme.yellow)
                                .clipShape(Capsule())
                        }
                        .disabled(selectedUserIds.isEmpty)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 100) // Add padding for custom tab bar
                    .background(Theme.surface)
                }
            }
            .navigationDestination(isPresented: $isSchedulingPresented) {
                InviteSchedulingView(
                    place: place,
                    selectedUsers: selectedUserIds,
                    onSend: {
                        // Perform final invite action
                        print("Inviting \(selectedUserIds.count) people to \(place.name)")
                        isSchedulingPresented = false
                        dismiss()
                    }
                )
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
            }
        }

        .onAppear {
            loadUsers()
        }
    }
    
    private func loadUsers() {
        let allPeople = MockDataService.shared.getPeople()
        // Randomly split for demo purposes
        // First 3 as friends, rest as mutuals
        if allPeople.count >= 3 {
            friends = Array(allPeople.prefix(3))
            mutuals = Array(allPeople.dropFirst(3))
        } else {
            friends = allPeople
            mutuals = []
        }
    }
    
    private func toggleSelection(for user: User) {
        if selectedUserIds.contains(user.id) {
            selectedUserIds.remove(user.id)
        } else {
            selectedUserIds.insert(user.id)
        }
    }
}

struct UserSelectionRow: View {
    let user: User
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(user.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text(user.username.isEmpty ? "@user" : "@\(user.username)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isSelected ? Theme.yellow : .gray)
            }
            .padding(12)
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Theme.yellow.opacity(0.5) : Color.clear, lineWidth: 1)
            )
        }
    }
}

#Preview {
    RestaurantInviteView(place: MockDataService.shared.getPlaces()[0])
}
