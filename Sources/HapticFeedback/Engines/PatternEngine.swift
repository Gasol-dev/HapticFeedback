//
//  PatternEngine.swift
//  HapticFeedback IOS
//
//  Created by MacBook on 11.12.2020.
//

import Foundation

// MARK: - PatternEngine

class PatternEngine {

    // MARK: - PatternChar

    private enum PatternChar: Character {
        case space = "-"
        case signalHeavy = "O"
        case signalMedium = "o"
        case signalLight = "."
    }

    // MARK: - Properties

    /// Finish flag
    var isFinished: Bool {
        return queue.operationCount == 0
    }

    /// Pattern
    var pattern: HapticFeedbackPattern!

    /// Operation queue
    lazy var queue: OperationQueue = {
        var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    /// Notification engine
    private var engine: HapticFeedbackNotificationEngine?

    /// Pause duration
    private var pauseDuration: TimeInterval

    // MARK: - Initializers

    /// Create engine pattern
    /// - Parameters:
    ///   - hapticEngine: hapticEngine instance
    ///   - pauseDuration: pauseDuration instance
    init(hapticEngine: HapticFeedbackNotificationEngine?, pauseDuration: TimeInterval = 0.11) {
        self.engine = hapticEngine
        self.pauseDuration = pauseDuration
    }

    // MARK: - Usefull

    func generate() {
        for (_, character) in pattern.pattern.enumerated() {
            if character == PatternChar.space.rawValue {
                queue.addOperation(PauseOperation(delay: pattern.delay))
            } else if character == PatternChar.signalHeavy.rawValue {
                queue.addOperation(SignalOperation(hapticEngine: engine, impact: .heavy, pauseDuration: pauseDuration))
            } else if character == PatternChar.signalMedium.rawValue {
                queue.addOperation(SignalOperation(hapticEngine: engine, impact: .medium, pauseDuration: pauseDuration))
            } else if character == PatternChar.signalLight.rawValue {
                queue.addOperation(SignalOperation(hapticEngine: engine, impact: .light, pauseDuration: pauseDuration))
            }
        }
    }
}

// MARK: - PauseOperation

class PauseOperation: Operation {

    // MARK: - Properties

    /// Delay
    private var delay: Double

    // MARK: - Initializers

    /// Delay
    /// - Parameter delay: delay instance
    init(delay: Double) {
        self.delay = delay
    }

    // MARK: - Overrides

    override func main() {
        Thread.sleep(forTimeInterval: delay)
    }
}

// MARK: - SignalOperation

class SignalOperation: Operation {

    // MARK: - Properties

    /// Notification engine
    weak var engine: HapticFeedbackNotificationEngine?

    /// Haptic feedback impact
    private var impact: HapticFeedbackImpact

    /// Pause duration
    private var pauseDuration: TimeInterval

    // MARK: - Initializers

    /// Create signal operation
    /// - Parameters:
    ///   - hapticEngine: hapticEngine instance
    ///   - impact: impact instance
    ///   - pauseDuration: pauseDuration instance
    init(
        hapticEngine: HapticFeedbackNotificationEngine?,
        impact: HapticFeedbackImpact,
        pauseDuration: TimeInterval
    ) {
        self.engine = hapticEngine
        self.impact = impact
        self.pauseDuration = pauseDuration
    }

    // MARK: - Overrides

    override func main() {
        guard #available(iOS 10, *) else { return }
        DispatchQueue.main.async {
            self.engine?.generate(self.impact)
        }
        Thread.sleep(forTimeInterval: pauseDuration)
    }
}
