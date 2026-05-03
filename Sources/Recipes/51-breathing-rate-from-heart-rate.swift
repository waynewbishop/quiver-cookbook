import Playgrounds
import Quiver
import Foundation

// Breathing Rate from Heart-Rate Variability
// Respiratory sinus arrhythmia is the small, regular oscillation
// in heart-rate intervals caused by breathing — heart rate speeds
// up on inhalation and slows on exhalation. The breathing rhythm
// is hidden inside the R-R interval signal and the Fourier
// transform extracts it. We center the signal, find the dominant
// frequency in Hz, and convert to breaths per minute.

#Playground("Breathing Rate from Heart-Rate Variability") {

    // Simulated R-R intervals at 4 Hz over two minutes (480 samples).
    // Modulation at 0.25 Hz corresponds to 15 breaths per minute,
    // baseline 1000 ms, amplitude ±50 ms.
    let sampleRate = 4.0
    let rrSignal = [Double].sineWave(
        frequency: 0.25, sampleRate: sampleRate, count: 480,
        amplitude: 50.0, offset: 1000.0
    )

    // Center the signal — remove the 1000 ms baseline
    let baseline = rrSignal.mean() ?? 0.0
    let centered = rrSignal - baseline

    // Find the breathing frequency in Hz, convert to breaths per minute
    guard let frequencyHz = centered.fourierDominantFrequency(
        sampleRate: sampleRate, windowed: true
    ) else { return }

    let breathsPerMinute = frequencyHz * 60.0
    print("Breathing frequency: \(String(format: "%.3f", frequencyHz)) Hz")
    print("Breaths per minute:  \(String(format: "%.1f", breathsPerMinute))")
    // ≈ 15.0 breaths per minute
}
