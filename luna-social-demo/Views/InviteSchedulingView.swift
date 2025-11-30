import SwiftUI

struct InviteSchedulingView: View {
    let place: Place
    let selectedUsers: Set<UUID>
    let onSend: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate = Date()
    @State private var message = ""
    @State private var selectedTimeSlot: TimeSlot?
    @State private var showSuccessPopup = false
    
    struct TimeSlot: Identifiable, Equatable {
        let id = UUID()
        let time: String
        let label: String
        let isBest: Bool
    }
    
    let smartSlots = [
        TimeSlot(time: "Tomorrow, 7:00 PM", label: "Perfect match for everyone", isBest: true),
        TimeSlot(time: "Friday, 8:00 PM", label: "Works for 3/4 people", isBest: false),
        TimeSlot(time: "Saturday, 1:00 PM", label: "Lunch time available", isBest: false)
    ]
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 8) {
                            Text("Plan the Details")
                                .font(Theme.headerFont(size: 28))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Inviting \(selectedUsers.count) people to \(place.name)")
                                .font(.subheadline)
                                .foregroundStyle(Theme.secondaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20) // Add top padding to avoid navbar overlap
                        
                        // Smart Suggestions
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "sparkles")
                                    .foregroundStyle(Theme.yellow)
                                Text("Suggested Times")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(smartSlots) { slot in
                                        Button {
                                            withAnimation {
                                                selectedTimeSlot = slot
                                                // Parse string to date for real app, mock for now
                                            }
                                        } label: {
                                            VStack(alignment: .leading, spacing: 8) {
                                                if slot.isBest {
                                                    Text("BEST MATCH")
                                                        .font(.caption2)
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.black)
                                                        .padding(.horizontal, 8)
                                                        .padding(.vertical, 4)
                                                        .background(Theme.yellow)
                                                        .clipShape(Capsule())
                                                }
                                                
                                                Text(slot.time)
                                                    .font(.headline)
                                                    .foregroundStyle(.white)
                                                
                                                Text(slot.label)
                                                    .font(.caption)
                                                    .foregroundStyle(Theme.secondaryText)
                                            }
                                            .padding(16)
                                            .frame(width: 200, height: 120, alignment: .topLeading)
                                            .background(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(Theme.surface)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(selectedTimeSlot == slot ? Theme.yellow : Color.clear, lineWidth: 2)
                                                    )
                                            )
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        // Manual Selection
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Or pick a specific time")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 20)
                            
                            DatePicker("", selection: $selectedDate)
                                .datePickerStyle(.graphical)
                                .colorScheme(.dark)
                                .padding()
                                .background(Theme.surface)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .padding(.horizontal, 20)
                                .onChange(of: selectedDate) { _ in
                                    selectedTimeSlot = nil // Clear smart slot if manual date picked
                                }
                        }
                        
                        // Optional Message
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Add a message (Optional)")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 20)
                            
                            TextField("Type something...", text: $message, axis: .vertical)
                                .lineLimit(3...6)
                                .padding()
                                .background(Theme.surface)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 20)
                        }
                        
                        Spacer(minLength: 120) // Ensure space for footer
                    }
                }
                
                // Footer
                VStack {
                    Button {
                        withAnimation {
                            showSuccessPopup = true
                        }
                        
                        // Delay dismissal to show animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            onSend()
                        }
                    } label: {
                        Text("Send Invite")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.yellow)
                            .clipShape(Capsule())
                    }
                }
                .padding(20)
                .background(Theme.surface)
            }
            
            // Success Popup
            if showSuccessPopup {
                Color.black.opacity(0.7).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(Theme.yellow)
                        .scaleEffect(showSuccessPopup ? 1 : 0.5)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showSuccessPopup)
                    
                    Text("Invite Sent!")
                        .font(Theme.headerFont(size: 24))
                        .foregroundStyle(.white)
                    
                    Text("We'll let you know when they respond.")
                        .font(.body)
                        .foregroundStyle(Theme.secondaryText)
                        .multilineTextAlignment(.center)
                }
                .padding(40)
                .background(Theme.surface)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(40)
                .transition(.scale.combined(with: .opacity))
            }
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
}
