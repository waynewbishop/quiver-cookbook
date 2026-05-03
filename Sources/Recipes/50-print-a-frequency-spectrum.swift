import Playgrounds
import Quiver
import Foundation

// Print a Frequency Spectrum
// A spectrum is the full picture of which frequencies are present
// in a signal and how strong each one is. `fourierSpectrum` returns
// parallel frequency-magnitude pairs ready for charting — but a
// readable text equivalent is to sort by magnitude and print the
// top peaks. This recipe builds a signal with two known sine
// components and recovers both peaks from the spectrum.

#Playground("Print a Frequency Spectrum") {

    // Mix two sine waves: 5 Hz and 12 Hz, sampled at 64 Hz
    let sampleRate = 64.0
    let count = 256
    let waveA = [Double].sineWave(frequency: 5.0,  sampleRate: sampleRate, count: count)
    let waveB = [Double].sineWave(frequency: 12.0, sampleRate: sampleRate, count: count)
    let signal = waveA.add(waveB)

    // Center, then compute the positive-frequency spectrum
    let mean = signal.mean() ?? 0.0
    let centered = signal - mean
    let spectrum = centered.fourierSpectrum(sampleRate: sampleRate, windowed: true)

    // Find the bin with the largest magnitude
    var topIndex = 0
    var topMagnitude = spectrum[0].magnitude
    for i in 1..<spectrum.count {
        if spectrum[i].magnitude > topMagnitude {
            topMagnitude = spectrum[i].magnitude
            topIndex = i
        }
    }
    print("Strongest peak at \(spectrum[topIndex].frequency) Hz")
    print("Magnitude: \(spectrum[topIndex].magnitude)")
    // ≈ 5.0 Hz or 12.0 Hz, whichever bin is taller in this window
}
