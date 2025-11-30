import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            if isLoading {
                LoadingView(isActive: $isLoading)
                    .transition(.opacity)
                    .zIndex(1)
            } else {
                // Entry point now shows the bottom tab bar (Feed is first tab)
                BottomTabBarView()
                    .transition(.opacity)
                    .zIndex(0)
            }
        }
    }
}

#Preview {
    ContentView()
}
