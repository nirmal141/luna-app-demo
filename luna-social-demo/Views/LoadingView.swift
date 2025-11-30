import SwiftUI

struct LoadingView: View {
    @Binding var isActive: Bool
    @State private var opacity = 0.0
    @State private var textScale = 0.9
    @State private var shimmerPhase: CGFloat = -0.5
    @State private var subtextOpacity = 0.0
    @State private var subtextOffset: CGFloat = 20
    
    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                // Title
                ZStack {
                    // Layer 1: Base Text (Dim)
                    Text("LUNA")
                        .font(Theme.headerFont(size: 60))
                        .fontWeight(.black)
                        .tracking(10)
                        .foregroundStyle(Color.white.opacity(0.3))
                    
                    // Layer 2: Shimmering Text (Bright)
                    Text("LUNA")
                        .font(Theme.headerFont(size: 60))
                        .fontWeight(.black)
                        .tracking(10)
                        .foregroundStyle(.white)
                        .mask(
                            GeometryReader { geometry in
                                LinearGradient(
                                    colors: [.clear, .white, .clear],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .frame(width: geometry.size.width * 2)
                                .offset(x: geometry.size.width * shimmerPhase)
                            }
                        )
                }
                .scaleEffect(textScale)
                .opacity(opacity)
                
                // Subtext
                Group {
                    Text("Connect with people & places that ")
                        .foregroundStyle(.white.opacity(0.7)) +
                    Text("matter to you")
                        .foregroundStyle(Theme.yellow)
                }
                .font(Font.roundedSubheadline())
                .multilineTextAlignment(.center)
                .opacity(subtextOpacity)
                .offset(y: subtextOffset)
            }
        }
        .onAppear {
            // Fade in and scale up Title
            withAnimation(.easeOut(duration: 1.2)) {
                opacity = 1.0
                textScale = 1.0
            }
            
            // Animate Subtext (delayed)
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                subtextOpacity = 1.0
                subtextOffset = 0
            }
            
            // Shimmer animation
            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                shimmerPhase = 1.5
            }
            
            // Transition to main app
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Increased slightly to read text
                withAnimation(.easeIn(duration: 0.4)) {
                    opacity = 0.0
                    subtextOpacity = 0.0
                    textScale = 1.1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    isActive = false
                }
            }
        }
    }
}

#Preview {
    LoadingView(isActive: .constant(true))
}
