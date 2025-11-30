import SwiftUI

struct PersonCardView: View {
    let user: User
    @State private var showPlaceSelection = false
    
    var body: some View {
        GeometryReader { proxy in
            let bottomInset = proxy.safeAreaInsets.bottom
            
            ZStack(alignment: .bottom) {
                // Background image - fills entire screen edge to edge
                Image(user.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                
                // Gradient overlay
                LinearGradient(
                    colors: [.clear, .black.opacity(0.8)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                // Foreground content
                VStack(alignment: .leading, spacing: 16) {
                    // Info Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .bottom, spacing: 8) {
                            Text(user.name)
                                .font(Theme.headerFont(size: 32))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                            
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(Theme.yellow)
                                .font(.title3)
                        }
                        
                        HStack(spacing: 6) {
                            Image(systemName: "graduationcap.fill")
                                .foregroundStyle(.white.opacity(0.7))
                            Text(user.university)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.white.opacity(0.9))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        
                        Text(user.bio)
                            .font(.body)
                            .foregroundStyle(.white.opacity(0.9))
                            .lineLimit(2)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 20)
                    
                    // Meet At card
                    HStack {
                        VStack(alignment: .leading, spacing: 4, ) {
                            Text("Meet At")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.white.opacity(0.7))
                                .textCase(.uppercase)
                                
                            
                            HStack(spacing: -8) {
                                ForEach(0..<3) { _ in
                                    Circle()
                                        .fill(Theme.surface)
                                        .frame(width: 32, height: 32)
                                        .overlay(
                                            Image(systemName: "building.2.fill")
                                                .font(.caption2)
                                                .foregroundStyle(Theme.text)
                                        )
                                        .overlay(
                                            Circle().stroke(Color.black, lineWidth: 2)
                                        )
                                }
                                
                                Circle()
                                    .fill(Theme.surface)
                                    .frame(width: 32, height: 32)
                                    .overlay(
                                        Text("+6")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Theme.text)
                                    )
                                    .overlay(
                                        Circle().stroke(Color.black, lineWidth: 2)
                                    )
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            showPlaceSelection = true
                        } label: {
                            Text("Invite")
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        .sheet(isPresented: $showPlaceSelection) {
                            PlaceSelectionView(user: user)
                        }
                    }
                    .padding(16)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
                // horizontal padding is fixed, bottom padding adapts to device
                .padding(.bottom, bottomInset + 124)
            }
        }
    }
}

#Preview {
    PersonCardView(user: MockDataService.shared.getPeople()[0])
}
