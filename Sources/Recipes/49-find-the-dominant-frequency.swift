import Playgrounds
import Quiver
import Foundation

// Find the Dominant Frequency in a Signal
// The Fourier transform converts a time-domain signal into its
// frequency-domain representation, revealing which cycles are
// hidden inside the data. The "hello world" of frequency analysis
// is recovering a known frequency from a synthetic sine wave.
// We center the signal by subtracting the mean (so the DC component
// stays out of the answer) and let `fourierDominantFrequency` find
// the strongest cycle. The `windowed: true` flag applies a Hann
// window to reduce spectral leakage on finite signals.

#Playground("Find the Dominant Frequency in a Signal") {

    // Generate a 5 Hz sine wave sampled at 64 Hz for 256 samples
    let sampleRate = 64.0
    let signal = [Double].sineWave(
        frequency: 5.0, sampleRate: sampleRate, count: 256
    )

    // Center the signal — subtract the mean so DC does not skew the result
    let mean = signal.mean() ?? 0.0
    let centered = signal - mean

    // Recover the dominant frequency, with windowing for cleaner edges
    guard let dominant = centered.fourierDominantFrequency(
        sampleRate: sampleRate, windowed: true
    ) else { return }

    print("Dominant frequency: \(dominant) Hz")  // ≈ 5.0 Hz
}
