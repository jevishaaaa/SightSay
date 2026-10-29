import Foundation
import Combine

#if canImport(ARKit)
import ARKit
class EyeTracker: NSObject, ObservableObject, ARSessionDelegate {
    @Published var isBlinking: Bool = false
    @Published var isTrackingFace: Bool = false
    var onBlinkDetected: (() -> Void)?
    
    private var arSession = ARSession()
    private var lastBlinkTime: Date = Date()
    private let blinkCooldown: TimeInterval = 1.2
    private let blinkThreshold: Float = 0.65
    
    override init() {
        super.init()
        arSession.delegate = self
    }
    
    func startTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        arSession.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func stopTracking() {
        arSession.pause()
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.first as? ARFaceAnchor else {
            DispatchQueue.main.async { self.isTrackingFace = false }
            return
        }
        DispatchQueue.main.async { self.isTrackingFace = true }
        
        let leftBlink = faceAnchor.blendShapes[.eyeBlinkLeft]?.floatValue ?? 0.0
        let rightBlink = faceAnchor.blendShapes[.eyeBlinkRight]?.floatValue ?? 0.0
        
        if leftBlink > blinkThreshold && rightBlink > blinkThreshold {
            let now = Date()
            if now.timeIntervalSince(lastBlinkTime) > blinkCooldown {
                lastBlinkTime = now
                DispatchQueue.main.async {
                    self.isBlinking = true
                    self.onBlinkDetected?()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isBlinking = false
                    }
                }
            }
        }
    }
}
#else
// Dummy tracker for macOS preview/testing without hardware
class EyeTracker: ObservableObject {
    @Published var isBlinking: Bool = false
    @Published var isTrackingFace: Bool = true
    var onBlinkDetected: (() -> Void)?
    func startTracking() {}
    func stopTracking() {}
}
#endif
