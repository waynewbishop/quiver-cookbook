// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Record a simulated run. Finalizing needs 60 seconds of active time.

#Playground("Score a Run with True Effort Score") {
    var effortScore = TrueEffortScore()
    let start = Date()

    // A 20-minute trail run sampled every 5 seconds (240 samples).
    // First half: steady running on gentle ground.
    // Second half: a simulated -6% descent with a lower heart rate.
    for sampleIndex in 0..<240 {
        let descending = sampleIndex >= 120
        let time = start.addingTimeInterval(Double(sampleIndex) * 5.0)

        effortScore.record(
            heartRate: descending ? 138.0 : 150.0,          // bpm
            pace: descending ? 5.1 : 5.6,                   // min/km
            cadence: descending ? 178.0 : 172.0,            // steps/min
            grade: descending ? -6.0 : 0.5,                 // percent, negative = downhill
            verticalOscillation: descending ? 9.2 : 7.8,    // cm
            altitude: 100.0 - (descending ? Double(sampleIndex - 120) * 0.3 : 0.0),  // meters
            at: time
        )
    }

    guard let result = effortScore.finalize() else { return }

    print(result)

    // This fixture records Tempo for both segments.
    for category in EffortClass.allCases {
        let seconds = result.time(in: category)
        if seconds > 0 {
            print("\(category): \(String(format: "%.1f", seconds / 60)) min")
        }
    }

    // A baseline learned during this run applies to future sessions.
    print("Mean residual: \(result.meanResidual as Any)")   // nil on a first run
    print("Baseline: \(effortScore.baseline?.equation() ?? "not learned yet")")
}
