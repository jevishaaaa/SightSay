// xcode: set sdk=iOS

import SwiftUI
import Combine

struct MessageItem: Identifiable {
    let id = UUID()
    let text: String
    let emoji: String
    let color: Color
}

struct ContentView: View {
    @StateObject private var sightsay = sightsay()
    @StateObject private var speechManager = SpeechManager()
    
    @State private var showOnboarding: Bool = false
    @State private var composedText: String = ""
    
    // Grid items updated with Emojis, featuring YES, NO, and IDK upfront
    let messages: [MessageItem] = [
        // Essential Daily Needs
        MessageItem(text: "I am Hungry", emoji: "🍕", color: .orange),
        MessageItem(text: "I am Thirsty", emoji: "🧃", color: .blue),
        MessageItem(text: "Need WC", emoji: "🚽", color: .indigo),
        MessageItem(text: "In Pain", emoji: "⚠️", color: .red),
        MessageItem(text: "Go Outside", emoji: "🛝", color: .green),
        MessageItem(text: "Off Lights", emoji: "💡", color: .gray),
        MessageItem(text: "Adjust Bed", emoji: "🛏️", color: .teal),
        MessageItem(text: "I Love You", emoji: "❤️", color: .pink),
        MessageItem(text: "Need Medicine", emoji: "💊", color: .mint),
        MessageItem(text: "YES", emoji: "✅", color: .green),
        MessageItem(text: "NO", emoji: "❌", color: .red),
        MessageItem(text: "IDK", emoji: "🤷‍♂️", color: .purple),
    ]
    
    @State private var selectedIndex: Int = 0
    private let timerPublisher = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()

    // 3 equal-width columns per row
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                // Header status bar
                HStack {
                    VStack(alignment: .leading) {
                        Text("BlinkSpeak")
                            .font(.title)
                            .bold()
                        Text("Eye-Tracking Communicator")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    // Onboarding Guide Button
                    Button(action: {
                        showOnboarding = true
                    }) {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 6)
                    
                    // Live Tracking Status Badge
                    HStack {
                        Circle()
                            .fill(sightsay.isTrackingFace ? Color.green : Color.red)
                            .frame(width: 10, height: 10)
                        Text(sightsay.isTrackingFace ? "Tracking" : "No Face")
                            .font(.caption2)
                            .bold()
                    }
                    .padding(8)
                    .background(Capsule().fill(Color.gray.opacity(0.2)))
                }
                .padding(.horizontal)
                
                // Interactive Text Box Above Grid
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("COMPOSED MESSAGE")
                            .font(.caption2)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        if !composedText.isEmpty {
                            Button(action: {
                                composedText = ""
                            }) {
                                HStack(spacing: 2) {
                                    Image(systemName: "trash.fill")
                                    Text("Clear")
                                }
                                .font(.caption2)
                                .foregroundColor(.red)
                            }
                        }
                    }
                    
                    // Display box showing selected expression
                    HStack {
                        Text(composedText.isEmpty ? "Selected expressions will appear here..." : composedText)
                            .font(.headline)
                            .bold()
                            .foregroundColor(composedText.isEmpty ? .gray.opacity(0.6) : .primary)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                        
                        Spacer()
                        
                        if !composedText.isEmpty {
                            Button(action: {
                                speechManager.speak(composedText)
                            }) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.title3)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(sightsay.isBlinking ? Color.green.opacity(0.25) : Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(sightsay.isBlinking ? Color.green : Color.clear, lineWidth: 2)
                )
                .padding(.horizontal)
                
                // 3-Column Emoji Expression Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(Array(messages.enumerated()), id: \.element.id) { index, item in
                            let isHighlighted = (index == selectedIndex)
                            
                            VStack(spacing: 6) {
                                Text(item.emoji)
                                    .font(.system(size: 36))
                                
                                Text(item.text)
                                    .font(.caption)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(isHighlighted ? .white : .primary)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(2)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 95)
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(isHighlighted ? item.color : Color.white)
                                    .shadow(color: isHighlighted ? item.color.opacity(0.4) : Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(isHighlighted ? Color.white : Color.clear, lineWidth: 2.5)
                            )
                            .scaleEffect(isHighlighted ? 1.04 : 1.0)
                            .animation(.spring(response: 0.3), value: isHighlighted)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Footer User Instructions
                HStack {
                    Image(systemName: "eye.fill")
                    Text("Focus on screen. Blink firmly when your choice highlights.")
                        .font(.caption2)
                }
                .foregroundColor(.secondary)
                .padding(.bottom, 6)
            }
            .padding(.top, 8)
        }
        .onAppear {
            sightsay.startTracking()
            sightsay.onBlinkDetected = {
                let currentItem = messages[selectedIndex]
                
                // Append selected phrase into text box and speak it aloud
                composedText = currentItem.text
                speechManager.speak(currentItem.text)
            }
        }
        .onDisappear {
           sightsay.stopTracking()
        }
        .onReceive(timerPublisher) { _ in
            selectedIndex = (selectedIndex + 1) % messages.count
        }
        .sheet(isPresented: $showOnboarding) {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
