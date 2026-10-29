# SightSay
👁️ An ARKit-powered hands-free assistive communicator using eye-blink tracking and speech synthesis for paralyzed and non-verbal individuals.
---
## 📌 Overview

**BlinkSpeak** enables completely non-verbal and paralyzed patients to communicate essential needs without physical movement. Using the front-facing **TrueDepth camera (ARKit)**, the app detects intentional eye blinks to select highlighted expressions from an on-screen grid and announces them aloud using iOS **Text-to-Speech (`AVFoundation`)**.

---

## ✨ Features

- 👁️ **ARKit Eye Tracking:** Continuous face-anchor tracking monitors eyelid closure blend shapes (`eyeBlinkLeft` & `eyeBlinkRight`) to capture intentional blinks.
- ⚡ **3-Column Emoji Grid:** Fast access to high-priority binary responses (`✅ YES`, `❌ NO`, `🤷‍♂️ IDK`) and essential health/comfort requests.
- 💬 **Interactive Text Box:** Dynamically builds composed messages, allowing caregivers to read or replay selections on demand.
- 🔊 **Text-to-Speech Integration:** Speaks phrases loudly and clearly across the room using `AVSpeechSynthesizer`.
- ℹ️ **Onboarding & Calibration Guide:** Integrated instruction modal for caregivers on device positioning and lighting requirements.
- 🔒 **100% On-Device & Offline:** Operates strictly on-device with zero network latency, ensuring complete user privacy.

---

## 🛠️ Project Architecture

| File | Purpose |
| :--- | :--- |
| `EyeTracker.swift` | Manages `ARSession`, monitors TrueDepth eye blend shapes, and handles blink thresholds & cooldowns. |
| `SpeechManager.swift` | Text-to-Speech wrapper utilizing `AVFoundation` for audio output. |
| `OnboardingView.swift` | Modal guidance view detailing target audience, setup instructions, and caregiver notes. |
| `ContentView.swift` | Primary SwiftUI user interface, 3-column expression grid, automatic selection timer, and text box engine. |

---

## 🚀 Setup & Requirements

### Hardware & OS Requirements
- **OS:** iOS 16.0 or later
- **Hardware:** Physical iPhone or iPad equipped with a **TrueDepth Camera** (required for ARKit Face Tracking).
- **IDE:** Xcode 15+ or Swift Playgrounds 4.4+

### Installation Steps
1. Clone this repository:
   ```bash
   git clone [https://github.com/your-username/BlinkSpeak.git](https://github.com/your-username/BlinkSpeak.git)
   ```
2. Open `BlinkSpeak.swiftpm` or `BlinkSpeak.xcodeproj` in **Xcode** or **Swift Playgrounds**.
3. Connect your physical iOS device.
4. Build and run (`Cmd + R`).

> **Note:** Camera Privacy permission (`NSCameraUsageDescription`) must be granted upon initial launch for eye tracking to function.

---

## 📄 License

Distributed under the **MIT License**. See `LICENSE` for details.
