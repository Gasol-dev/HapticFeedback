//
//  HapticFeedbackNotificationEngine.swift
//  HapticFeedback IOS
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

// MARK: - HapticFeedbackNotificationEngine

final class HapticFeedbackNotificationEngine: HapticFeedbackEngine {

    // MARK: - Properties

    /// Log flag
    var logEnabled: Bool!

    /// Haptic feed back generator
    @available(iOS 10.0, *)
    private var generator: UINotificationFeedbackGenerator {
        return UINotificationFeedbackGenerator()
    }

    /// Haptic feed back impact generator
    @available(iOS 10.0, *)
    private var impactGenerator: (light: UIImpactFeedbackGenerator, medium: UIImpactFeedbackGenerator, heavy: UIImpactFeedbackGenerator) {
        return (light: UIImpactFeedbackGenerator(style: .light), medium: UIImpactFeedbackGenerator(style: .medium), heavy: UIImpactFeedbackGenerator(style: .heavy))
    }

    // MARK: - Usefull

    func prepare() throws {
        guard #available(iOS 10, *) else { throw HapticFeedbackError.notSupportedByOS }
        guard UIDevice.current.hasHapticFeedback else { throw HapticFeedbackError.notSupportedByDevice }
        generator.prepare()
        impactGenerator.heavy.prepare()
        impactGenerator.medium.prepare()
        impactGenerator.light.prepare()
    }

    func generate(_ notification: HapticFeedbackNotification) {
        guard #available(iOS 10, *) else { return }
        guard UIDevice.current.hasHapticFeedback else { return }
        switch notification {
        case .success:
            generator.notificationOccurred(.success)
        case .warning:
            generator.notificationOccurred(.warning)
        case .error:
            generator.notificationOccurred(.error)
        }
    }

    func generate(_ impact: HapticFeedbackImpact) {
        guard #available(iOS 10, *) else { return }
        guard UIDevice.current.hasHapticFeedback else { return }
        switch impact {
        case .light:
            impactGenerator.light.impactOccurred()
        case .medium:
            impactGenerator.medium.impactOccurred()
        case .heavy:
            impactGenerator.heavy.impactOccurred()
        }
    }
}

