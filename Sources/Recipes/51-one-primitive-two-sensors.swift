// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Find the strongest rhythm in two simulated sensor signals.

#Playground("One Primitive, Two Sensors") {
    // Simulated beat intervals. The 0.25 Hz rhythm is 15 breaths per minute.
    let beatIntervals = [Double].sineWave(
        frequency: 0.25, sampleRate: 4.0, count: 480,
        amplitude: 50.0, offset: 1000.0
    )
    let centeredIntervals = beatIntervals - (beatIntervals.mean() ?? 0.0)

    if let breathingFrequency = centeredIntervals.powerSpectralDensity(
        sampleRate: 4.0, windowed: true
    )?.dominantFrequency {
        print("Breathing frequency: \(String(format: "%.3f", breathingFrequency)) Hz")
        print("Breaths per minute:  \(String(format: "%.1f", breathingFrequency * 60.0))")
        // ≈ 15.0 breaths per minute
    }

    // Simulated vertical acceleration. A 3 Hz rhythm is 180 steps per minute.
    let acceleration = [Double].sineWave(
        frequency: 3.0, sampleRate: 50.0, count: 256,
        amplitude: 1.5, offset: 9.81
    )
    let centeredAcceleration = acceleration - (acceleration.mean() ?? 0.0)

    if let stepFrequency = centeredAcceleration.powerSpectralDensity(
        sampleRate: 50.0, windowed: true
    )?.dominantFrequency {
        print("Step frequency: \(String(format: "%.2f", stepFrequency)) Hz")
        print("Cadence:        \(String(format: "%.0f", stepFrequency * 60.0)) steps/min")
        // ≈ 180 steps/min
    }
}
