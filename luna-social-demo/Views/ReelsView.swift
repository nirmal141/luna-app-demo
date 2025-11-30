import SwiftUI

struct ReelsView: View {
    @State private var reels: [Reel] = []
    @State private var currentIndex: Int = 0
    @State private var isUIHidden = false
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $currentIndex) {
                ForEach(Array(reels.enumerated()), id: \.element.id) { index, reel in
                    ReelPlayerView(reel: reel, isUIHidden: isUIHidden)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .ignoresSafeArea()
        }
        .background(Color.black)
        .ignoresSafeArea()
        .overlay(alignment: .top) {
            HStack {
                Text("Places & People")
                    .font(Theme.headerFont(size: 28))
                    .foregroundStyle(Theme.text)
                
                Spacer()
                
                Button {
                    withAnimation {
                        isUIHidden.toggle()
                    }
                } label: {
                    Image(systemName: isUIHidden ? "eye.slash.fill" : "eye.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 5) // Adjust for safe area
        }
        .onAppear {
            reels = MockDataService.shared.getReels()
        }
    }
}

#Preview {
    ReelsView()
}