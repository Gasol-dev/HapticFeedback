//
//  TapticEngine.swift
//  HapticFeedback IOS
//
//  Created by MacBook on 11.12.2020.
//

import UIKit
import AudioToolbox.AudioServices

// MARK: - TapticEngine

final class TapticEngine: HapticFeedbackEngine {

// MARK: - SoundID

    struct SoundID {
        static let successID = SystemSoundID(1519)
        static let warningID = SystemSoundID(1102)
        static let errorID = SystemSoundID(1107)
    }

    // MARK: - Properties

    /// Log flag
    var logEnabled: Bool!

// MARK: - Usefull

    func prepare() throws {
        guard #available(iOS 9, *) else { throw HapticFeedbackError.notSupportedByOS }
        guard UIDevice.current.hasTapticEngine else { throw HapticFeedbackError.notSupportedByDevice }
    }

    func generate(_ notification: HapticFeedbackNotification) {
        guard #available(iOS 9, *) else { return }
        guard UIDevice.current.hasTapticEngine else { return }

        switch notification {
        case .success:
            AudioServicesPlaySystemSoundWithCompletion(SoundID.successID, nil)
        case .warning:
            AudioServicesPlaySystemSoundWithCompletion(SoundID.warningID, nil)
        case .error:
            AudioServicesPlaySystemSoundWithCompletion(SoundID.errorID, nil)
        }
    }
}
