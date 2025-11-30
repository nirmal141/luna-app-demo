import SwiftUI

struct PeopleView: View {
    @State private var people: [User] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Swipeable Content
                TabView {
                    ForEach(people) { person in
                        PersonCardView(user: person)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                
                // Header & Search Overlay
                VStack(spacing: 0) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.white.opacity(0.7))
                        Text("Search people and places")
                            .foregroundStyle(.white.opacity(0.7))
                        Spacer()
                    }
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .padding(.horizontal, 16)
                    .padding(.top, 60) // Safe area adjustment
                    
                    Spacer()
                }
            }
            .background(Color.black)
            .ignoresSafeArea()
            .onAppear {
                people = MockDataService.shared.getPeople()
            }
        }
    }
}

#Preview {
    PeopleView()
}
