import Playgrounds
import Quiver

// Smooth a Noisy Signal
// Raw sensor data is often jittery. A rolling mean averages
// each point with its neighbors, revealing the underlying trend.

#Playground("Smooth a Noisy Signal") {

    // Heart rate readings — real sensors fluctuate between beats
    let raw = [72.0, 78.0, 71.0, 85.0, 74.0, 80.0, 73.0, 82.0, 76.0, 79.0]

    // Rolling mean with a window of 3:
    // Each output value = average of itself and its 2 predecessors
    // First two values have smaller windows (only 1 and 2 values available)
    let smooth = raw.rollingMean(window: 3)

    // The trend is now visible — the spikes are dampened
    // Larger windows = smoother signal but slower to react
    let verySmooth = raw.rollingMean(window: 5)

    print("Raw:         \(raw)")
    print("Smoothed(3): \(smooth)")
    print("Smoothed(5): \(verySmooth)")

    // The overall trend: is heart rate rising, falling, or stable?
    let trend = raw.percentChange(lag: 1)
    print("Changes:     \(trend)")
}
