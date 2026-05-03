import Playgrounds
import Quiver
import Foundation

// Stride Frequency from Accelerometer Data
// A running watch records acceleration many times per second.
// Each footstrike shows up as a peak in that signal, so the
// step rate is the dominant frequency of the accelerometer
// stream. We simulate a one-second window of running at roughly
// 180 steps per minute (3 Hz), recover the frequency with the
// Fourier transform, and convert it to a steps-per-minute cadence
// — the same number a watchOS app would surface during a workout.

#Playground("Stride Frequency from Accelerometer Data") {

    // Simulated vertical acceleration during running.
    // 3 Hz footstrike rate sampled at 50 Hz over ~5 seconds (256 samples)
    let sampleRate = 50.0
    let acceleration = [Double].sineWave(
        frequency: 3.0, sampleRate: sampleRate, count: 256,
        amplitude: 1.5, offset: 9.81
    )

    // Center — strip the gravity offset so DC does not dominate
    let baseline = acceleration.mean() ?? 0.0
    let centered = acceleration - baseline

    // Find the footstrike frequency and convert to cadence
    guard let stepHz = centered.fourierDominantFrequency(
        sampleRate: sampleRate, windowed: true
    ) else { return }

    let cadence = stepHz * 60.0
    print("Step frequency: \(String(format: "%.2f", stepHz)) Hz")
    print("Cadence:        \(String(format: "%.0f", cadence)) steps/min")
    // ≈ 180 steps/min
}
