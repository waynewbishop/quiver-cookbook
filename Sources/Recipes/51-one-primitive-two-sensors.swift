import Playgrounds
import Quiver
import Foundation

// One Primitive, Two Sensors
// Recipe 49 recovered a known frequency from a synthetic sine wave.
// The same primitive — center the signal, then ask
// powerSpectralDensity for the dominant frequency — reads two very
// different sensor streams on a watch:
//
//   • Breathing: heart rate speeds up on inhalation and slows on
//     exhalation (respiratory sinus arrhythmia). The breathing rhythm
//     hides inside the R-R interval signal as a small oscillation.
//   • Stride: each footstrike during a run is a peak in the
//     accelerometer stream, so step rate is its dominant frequency.
//
// Neither needs a dedicated sensor — the Fourier transform extracts
// both from signals the watch already records.

#Playground("One Primitive, Two Sensors") {

    // --- Breathing rate from heart-rate variability ---
    // Simulated R-R intervals at 4 Hz over two minutes (480 samples).
    // Modulation at 0.25 Hz corresponds to 15 breaths per minute,
    // baseline 1000 ms, amplitude ±50 ms.
    let rrSignal = [Double].sineWave(
        frequency: 0.25, sampleRate: 4.0, count: 480,
        amplitude: 50.0, offset: 1000.0
    )
    let rrCentered = rrSignal - (rrSignal.mean() ?? 0.0)

    if let breathHz = rrCentered.powerSpectralDensity(
        sampleRate: 4.0, windowed: true
    )?.dominantFrequency {
        print("Breathing frequency: \(String(format: "%.3f", breathHz)) Hz")
        print("Breaths per minute:  \(String(format: "%.1f", breathHz * 60.0))")
        // ≈ 15.0 breaths per minute
    }

    // --- Stride frequency from the accelerometer ---
    // Simulated vertical acceleration: 3 Hz footstrike rate (about
    // 180 steps per minute) sampled at 50 Hz, riding on gravity.
    let accel = [Double].sineWave(
        frequency: 3.0, sampleRate: 50.0, count: 256,
        amplitude: 1.5, offset: 9.81
    )
    let accelCentered = accel - (accel.mean() ?? 0.0)

    if let stepHz = accelCentered.powerSpectralDensity(
        sampleRate: 50.0, windowed: true
    )?.dominantFrequency {
        print("Step frequency: \(String(format: "%.2f", stepHz)) Hz")
        print("Cadence:        \(String(format: "%.0f", stepHz * 60.0)) steps/min")
        // ≈ 180 steps/min
    }

    // Same calls, same shape — only the sample rate, frequency, and
    // units changed. This is the pattern True Effort Score (Recipe 80)
    // builds on: simple primitives, read together, per moment.
}
