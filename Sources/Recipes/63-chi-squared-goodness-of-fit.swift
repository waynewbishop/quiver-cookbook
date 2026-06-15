import Playgrounds
import Quiver

// Chi-Squared Goodness of Fit
// We rolled a die 60 times. If the die is fair, each face should
// appear about 10 times. The chi-squared goodness-of-fit statistic
// summarizes how far observed counts drifted from expected counts;
// the chi-squared distribution's CDF turns that into a p-value.
// Small p means the die looks rigged.

#Playground("Chi-Squared Goodness of Fit") {

    // Observed counts for faces 1–6 across 60 rolls
    let observed: [Double] = [9, 11, 8, 12, 10, 10]
    let expected: [Double] = [10, 10, 10, 10, 10, 10]   // fair die hypothesis

    // chi-squared statistic = Σ (observed - expected)² / expected
    let diffs = observed.subtract(expected)
    let squared = diffs.multiply(diffs)
    let terms = squared.divide(expected)
    let chiSquared = terms.sum()

    let degreesOfFreedom = Double(observed.count - 1)

    // p-value = P(χ² ≥ observed) = 1 - CDF(observed)
    guard let lowerTail = Distributions.chiSquared.cdf(x: chiSquared,
                                                       df: degreesOfFreedom) else {
        return
    }
    let pValue = 1.0 - lowerTail

    print("chi-squared:   \(String(format: "%.4f", chiSquared))")   // 1.0
    print("df:            \(Int(degreesOfFreedom))")                // 5
    print("p-value:       \(String(format: "%.4f", pValue))")       // ~0.96
    print()
    print(pValue < 0.05
        ? "Reject — the die is not fair."
        : "Cannot reject — the counts are consistent with a fair die.")
}
