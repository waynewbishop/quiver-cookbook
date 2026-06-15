import Playgrounds
import Quiver

// Inter-Arrival Times with randomExponential
// Server requests, user events, customer arrivals — when events
// happen at a steady average rate but with random spacing, the
// gaps between them follow an exponential distribution. The mean
// gap is 1/rate. Use randomExponential to simulate realistic
// arrival patterns when load testing or modeling capacity.

#Playground("Inter-Arrival Times") {

    var rng = SeededRandomNumberGenerator(seed: 31)

    // Suppose API requests arrive at 5 per second on average.
    // The gap between requests is exponential with rate = 5.0,
    // so the mean inter-arrival time is 1/5 = 0.2 seconds.
    let rate = 5.0
    let gaps = [Double].randomExponential(20, rate: rate, using: &rng)

    print("Inter-arrival times (seconds):")
    for (i, gap) in gaps.enumerated() {
        print("  request \(i + 1): \(String(format: "%.4f", gap))s")
    }
    print()
    print("observed mean gap: \(String(format: "%.4f", gaps.mean() ?? 0))s")
    print("expected mean gap: \(String(format: "%.4f", 1.0 / rate))s")
    print()
    print("Notice the spread — some requests arrive almost back-to-back,")
    print("others have long gaps. That is the memoryless property of")
    print("the exponential distribution.")
}
