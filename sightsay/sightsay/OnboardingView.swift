// xcode: set sdk=iOS

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Header Banner
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome to BlinkSpeak")
                            .font(.largeTitle)
                            .bold()
                        Text("Empowering hands-free communication through gaze and blink interaction.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    Divider()
                    
                    // Section: Who is this for?
                    FeatureCard(
                        icon: "person.crop.circle.badge.checkmark",
                        color: .blue,
                        title: "Who It Is For",
                        description: "Designed for individuals with severe motor impairments, ALS, locked-in syndrome, or full paralysis who cannot speak or move their limbs."
                    )
                    
                    // Section: How it Works
                    FeatureCard(
                        icon: "eye.trianglebadge.exclamationmark",
                        color: .orange,
                        title: "How It Works",
                        description: "The app automatically highlights phrases one by one. Simply close your eyes firmly (blink) when your desired message is highlighted to select and speak it aloud."
                    )
                    
                    // Section: Caregiver Note
                    FeatureCard(
                        icon: "heart.text.square.fill",
                        color: .pink,
                        title: "Caregiver & Family Support",
                        description: "Provides instant auditory text-to-speech output so caregivers across the room can immediately understand essential needs like food, water, or medical assistance."
                    )
                    
                    // Section: Calibration Tips
                    FeatureCard(
                        icon: "slider.horizontal.3",
                        color: .purple,
                        title: "Setup & Calibration Tips",
                        description: "Position the device securely on a stand facing the user's face at eye level. Ensure good room lighting so the TrueDepth camera can reliably track face anchors."
                    )
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Got It, Start Communicating")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(16)
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FeatureCard: View {
    let icon: String
    let color: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .bold()
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    OnboardingView()
}
