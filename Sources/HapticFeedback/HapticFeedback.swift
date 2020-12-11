//
//  HapticFeedback.swift
//  HapticFeedback
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

// MARK: - HapticFeedbackError

enum HapticFeedbackError: Error {
    case notSupportedByOS
    case notSupportedByDevice
    case notSupported
}

// MARK: - HapticFeedbackNotification

public enum HapticFeedbackNotification {
    case success
    case warning
    case error
}

// MARK: - HapticFeedbackImpact

public enum HapticFeedbackImpact {
    case light
    case medium
    case heavy
}

// MARK: - HapticFeedback

public final class HapticFeedback {

    // MARK: - Properties

    /// Shared haptic feedback
    private static var sharedHapticFeedback: HapticFeedback = {
        let hapticFeedback = HapticFeedback()
        return hapticFeedback
    }()

    /// haptic feedback engine
    private var engine: HapticFeedbackEngine? {
        let currentDevice = UIDevice.current
        var engine: HapticFeedbackEngine?

        if currentDevice.hasHapticFeedback {
            engine = HapticFeedbackNotificationEngine()
        } else if currentDevice.hasTapticEngine {
            engine = TapticEngine()
        } else {
            engine = nil
        }
        engine?.logEnabled = logEnabled
        return engine
    }

    /// Pattern engine
    private var patternEngine: PatternEngine?

    /// Log flag
    public var logEnabled: Bool = true

    // MARK: - Usefull

    public class func shared() -> HapticFeedback {
        return sharedHapticFeedback
    }

    public func prepare() throws {
        guard let engine = engine else {
            if logEnabled {
                print("HapticFeedback 📳: Device name - \(UIDevice.current.deviceType.displayName)")
            }
            throw HapticFeedbackError.notSupported
        }
        try engine.prepare()
    }

    public func generate(_ feedbackNotification: HapticFeedbackNotification) {
        engine?.generate(feedbackNotification)
    }

    public func generate(_ impact: HapticFeedbackImpact) {
        guard let engine = self.engine as? HapticFeedbackNotificationEngine else { return }
        engine.generate(impact)
    }

    public func generateFeedbackFromPattern(_ pattern: String, delay: Double) {
        guard let engine = self.engine as? HapticFeedbackNotificationEngine else { return }
        if patternEngine == nil {
            patternEngine = PatternEngine(hapticEngine: engine)
        }
        guard let patternEngine = self.patternEngine, patternEngine.isFinished else { return }
        let pattern = HapticFeedbackPattern(pattern: pattern, delay: delay)
        patternEngine.pattern = pattern
        patternEngine.generate()
    }
}
