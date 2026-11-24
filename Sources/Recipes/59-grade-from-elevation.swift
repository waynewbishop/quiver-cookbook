// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Grade from Elevation with derivative()
// The elevation derivative gives vertical speed. Percent grade uses
// elevation change divided by horizontal distance over each interval.

#Playground("Grade from Elevation with derivative()") {
    // Elevation samples (meters) recorded every second on a hilly run
    let elevation = [100.0, 100.2, 100.5, 100.9, 101.2,
                     101.4, 101.3, 101.0, 100.7, 100.5]

    let verticalSpeed = elevation.derivative(sampleRate: 1.0)
    print("Vertical speed (m/s):", verticalSpeed.map { String(format: "%.2f", $0) })

    // Cumulative horizontal distance (meters), aligned with elevation.
    let distance = [0.0, 3.0, 6.2, 9.6, 13.1, 16.6, 20.2, 24.0, 28.0, 32.1]
    let horizontalSpeed = distance.derivative(sampleRate: 1.0)
    let grade = verticalSpeed.divide(horizontalSpeed).map { 100 * $0 }
    print("Percent grade:", grade.map { String(format: "%.1f%%", $0) })

    // Speed samples (m/s) recorded every second over the same window
    let speed = [3.0, 3.2, 3.4, 3.5, 3.5, 3.6, 3.8, 4.0, 4.1, 4.0]

    // Acceleration is the rate of change of speed — same primitive
    let acceleration = speed.derivative(sampleRate: 1.0)
    print("Acceleration (m/s²):")
    for value in acceleration {
        print("  \(String(format: "%.2f", value))")
    }
    // 0.20, 0.20, 0.10, 0.00, 0.10, 0.20, 0.20, 0.10, -0.10
}
