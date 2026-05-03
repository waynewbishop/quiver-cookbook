import Playgrounds
import Quiver
import Foundation

// Confidence Interval for a Sample Mean
// A point estimate — "the mean is 84.6" — gives no sense of how
// reliable that number is. A confidence interval gives the answer
// honesty: a range that plausibly contains the true mean. The
// bootstrap is the most direct way to compute one. We resample
// the data with replacement many times, take the mean of each
// resample, and read the 2.5th and 97.5th percentiles of the
// resulting distribution. The seeded generator means anyone who
// runs this recipe gets the same interval.

#Playground("Confidence Interval for a Sample Mean") {

    // Inline sample of test scores
    let scores = [88.0, 72.0, 95.0, 81.0, 90.0, 76.0, 84.0, 91.0,
                  79.0, 87.0, 93.0, 70.0, 82.0, 89.0, 85.0]

    // Bootstrap distribution of the mean — 1,000 resamples, fixed seed.
    // The trailing closure is the statistic: a function from a resample
    // to a single number. Here it's the resample's mean.
    let resampledMeans = scores.resampled(iterations: 1000, seed: 42) {
        resample in resample.mean() ?? 0.0
    }

    // 95% percentile confidence interval from the resampled distribution
    guard let ci = resampledMeans.percentileCI(level: 0.95) else { return }

    let pointEstimate = scores.mean() ?? 0.0
    print("Sample mean: \(String(format: "%.2f", pointEstimate))")
    print("95% CI lower: \(String(format: "%.2f", ci.lower))")
    print("95% CI upper: \(String(format: "%.2f", ci.upper))")
}
