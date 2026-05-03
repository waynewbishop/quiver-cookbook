import Playgrounds
import Quiver
import Foundation

// Confidence Interval for the Median
// The bootstrap recipe is not specific to the mean. The same
// resampling primitive supports any statistic — median, variance,
// trimmed mean, or anything we can express as a closure on a
// `[Double]`. This recipe uses skewed income data, where the mean
// is dragged upward by a few large values and the median better
// represents the typical case. Building a confidence interval
// for the median is the right move when the distribution is not
// symmetric.

#Playground("Confidence Interval for the Median") {

    // Skewed sample: most incomes cluster low, a few are very high
    let incomes = [38.0, 42.0, 45.0, 48.0, 51.0, 54.0, 57.0, 60.0,
                   62.0, 65.0, 68.0, 75.0, 92.0, 130.0, 220.0]

    let pointMean   = incomes.mean()   ?? 0.0
    let pointMedian = incomes.median() ?? 0.0
    print("Sample mean:   \(String(format: "%.1f", pointMean))")     // ≈ 73.8
    print("Sample median: \(String(format: "%.1f", pointMedian))")   // 60.0

    // Bootstrap the median — same primitive, different statistic.
    // The trailing closure swaps `median()` for `mean()` and that's
    // the entire change from Recipe 56.
    let resampledMedians = incomes.resampled(iterations: 1000, seed: 42) {
        resample in resample.median() ?? 0.0
    }

    guard let ci = resampledMedians.percentileCI(level: 0.95) else { return }

    print("95% CI for median (lower): \(String(format: "%.1f", ci.lower))")
    print("95% CI for median (upper): \(String(format: "%.1f", ci.upper))")
}
