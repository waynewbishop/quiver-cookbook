import Playgrounds
import Quiver

// Build a Histogram
// A histogram groups data into bins and counts how many
// values fall in each range. It reveals the shape of your data:
// is it clustered in the middle? skewed to one side? spread evenly?

#Playground("Build a Histogram") {

    // Generate 50 values from a normal distribution
    // mean = 100, std = 15 — like IQ scores
    let data = [Double].randomNormal(50, mean: 100.0, std: 15.0)

    // Group into 5 bins — each bin covers an equal range
    let bins = data.histogram(bins: 5)

    // Each bin has a midpoint (center of the range) and a count
    print("Distribution:")
    for bin in bins {
        let bar = String(repeating: "█", count: bin.count)
        print("  \(String(format: "%6.1f", bin.midpoint)): \(bar) (\(bin.count))")
    }

    // Most values cluster near the mean (100) — that's the bell curve
    // Fewer values appear in the tails (far from the mean)
}
