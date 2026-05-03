import Playgrounds
import Quiver
import Foundation

// Grade from Elevation with derivative()
// `derivative(sampleRate:)` is the finite-difference operator —
// it divides consecutive differences by the sample interval. The
// result has one fewer element than the input because each output
// is the rate of change between two adjacent samples. The same
// operator that converts elevation to grade also converts speed
// to acceleration; one primitive serves both signals on the kind
// of sensor stream a watchOS workout app records every second.

#Playground("Grade from Elevation with derivative()") {

    // Elevation samples (meters) recorded every second on a hilly run
    let elevation = [100.0, 102.0, 105.0, 109.0, 112.0,
                     114.0, 113.0, 110.0, 107.0, 105.0]

    // Grade is the rate of change of elevation per second
    let grade = elevation.derivative(sampleRate: 1.0)
    print("Grade (m/s): \(grade)")
    // [2.0, 3.0, 4.0, 3.0, 2.0, -1.0, -3.0, -3.0, -2.0]

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
