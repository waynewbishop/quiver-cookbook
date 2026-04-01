import Playgrounds
import Quiver

// Find the Outliers
// An outlier is a data point that falls far from the rest.
// outlierMask uses z-scores: how many standard deviations
// a value sits from the mean. Values beyond the threshold are flagged.

#Playground("Find the Outliers") {

    // Daily temperature readings — two days look unusual
    let temps = [72.0, 68.5, 71.2, 70.1, 69.8, 66.3, 71.8, 95.2, 70.5, 38.1]

    // Create a boolean mask: true where |z-score| > 1.5
    // z-score = (value - mean) / standard deviation
    let mask = temps.outlierMask(threshold: 1.5)
    // [false, false, false, false, false, false, false, true, false, true]

    // Split data using the mask
    let normal = temps.masked(by: mask.not)   // readings within range
    let flagged = temps.masked(by: mask)       // unusual readings

    // maskedWithIndices preserves the original position of each
    // flagged value — useful for chart annotations and reports
    let outliers = temps.maskedWithIndices(by: mask)
    // [(index: 7, value: 95.2), (index: 9, value: 38.1)]

    print("Normal readings: \(normal)")     // 8 typical temperatures
    print("Outliers:        \(flagged)")     // [95.2, 38.1] — the unusual days
    for outlier in outliers {
        print("  Day \(outlier.index): \(outlier.value)")
    }
}
