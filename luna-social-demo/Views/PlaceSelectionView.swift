import SwiftUI

struct PlaceSelectionView: View {
    let user: User
    @Environment(\.dismiss) private var dismiss
    @State private var places: [Place] = []
    @State private var selectedPlace: Place?
    @State private var isSchedulingPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    Text("Pick a Place")
                        .font(Theme.headerFont(size: 28))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                    
                    Text("Where do you want to meet \(user.name)?")
                        .font(.subheadline)
                        .foregroundStyle(Theme.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    
                    // Place List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(places) { place in
                                PlaceSelectionRow(place: place, isSelected: selectedPlace?.id == place.id) {
                                    withAnimation(.spring()) {
                                        selectedPlace = place
                                    }
                                }
                            }
                        }
                        .padding(20)
                    }
                    
                    // Footer Action
                    VStack {
                        Button {
                            isSchedulingPresented = true
                        } label: {
                            Text("Next")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedPlace == nil ? Color.gray : Theme.yellow)
                                .clipShape(Capsule())
                        }
                        .disabled(selectedPlace == nil)
                    }
                    .padding(20)
                    .background(Theme.surface)
                }
            }
            .navigationDestination(isPresented: $isSchedulingPresented) {
                if let place = selectedPlace {
                    InviteSchedulingView(
                        place: place,
                        selectedUsers: [user.id],
                        onSend: {
                            print("Inviting \(user.name) to \(place.name)")
                            isSchedulingPresented = false
                            dismiss()
                        }
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
            }
            .onAppear {
                places = MockDataService.shared.getPlaces()
            }
        }
    }
}

struct PlaceSelectionRow: View {
    let place: Place
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: place.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(place.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text(place.location)
                        .font(.caption)
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
