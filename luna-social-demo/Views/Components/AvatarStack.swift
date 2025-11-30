import SwiftUI
import UIKit // Added for UIColor

struct AvatarStack: View {
    let users: [User]
    
    var body: some View {
        HStack(spacing: -12) {
            // We use 'id: \.self' or just let Identifiable handle it
            ForEach(users.prefix(4)) { user in
                Image(user.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.gray)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 2.5)
                    )
            }
            if users.count > 4 {
                Text("+\(users.count - 4)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .frame(width: 32, height: 32)
                    .background(Color(uiColor: UIColor.systemGray5))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
            }
        }
    }
}
