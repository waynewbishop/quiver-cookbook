import Playgrounds
import Quiver
import Foundation

// Confidence Intervals with the Bootstrap
// A point estimate — "the mean is 84.6" — gives no sense of how
// reliable that number is. A confidence interval gives the answer
// honestly: a range that plausibly contains the true value. The
// bootstrap is the most direct way to compute one: resample the data
// with replacement many times, take the statistic of each resample,
// and read the 2.5th and 97.5th percentiles of the resulting
// distribution. The seeded generator means anyone who runs this
// recipe gets the same interval.
//
// The bootstrap is not specific to the mean. The trailing closure is
// the statistic — any function from a resample to a single number —
// so median, variance, or anything expressible on a [Double] works.

#Playground("Confidence Intervals with the Bootstrap") {

    // Skewed sample: most incomes cluster low, a few are very high
    let incomes = [38.0, 42.0, 45.0, 48.0, 51.0, 54.0, 57.0, 60.0,
                   62.0, 65.0, 68.0, 75.0, 92.0, 130.0, 220.0]

    let pointMean   = incomes.mean()   ?? 0.0
    let pointMedian = incomes.median() ?? 0.0
    print("Sample mean:   \(String(format: "%.1f", pointMean))")     // ≈ 73.8
    print("Sample median: \(String(format: "%.1f", pointMedian))")   // 60.0

    // Bootstrap the mean — 1,000 resamples, fixed seed
    let resampledMeans = incomes.resampled(iterations: 1000, seed: 42) {
        resample in resample.mean() ?? 0.0
    }

    // Bootstrap the median — the entire change is the closure.
    // The median is the better summary here: the mean is dragged
    // upward by a few large values.
    let resampledMedians = incomes.resampled(iterations: 1000, seed: 42) {
        resample in resample.median() ?? 0.0
    }

    // 95% percentile confidence intervals from each distribution
    guard let meanCI = resampledMeans.percentileCI(level: 0.95),
          let medianCI = resampledMedians.percentileCI(level: 0.95) else { return }

    print("95% CI for mean:   [\(String(format: "%.1f", meanCI.lower)), \(String(format: "%.1f", meanCI.upper))]")
    print("95% CI for median: [\(String(format: "%.1f", medianCI.lower)), \(String(format: "%.1f", medianCI.upper))]")

    // Same primitive, two statistics. Recipe 65 shows the parametric
    // alternative — shorter code and exact coverage when the sample
    // is reasonably symmetric; the bootstrap makes no such assumption.
}
