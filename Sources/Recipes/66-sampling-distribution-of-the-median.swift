import Playgrounds
import Quiver

// Sampling Distribution of the Median
// The mean's sampling distribution is the Central Limit Theorem's
// canonical illustration. The median has its own sampling
// distribution — and on symmetric data, it is wider than the mean's
// at the same sample size. That is the quantitative version of "the
// mean is the more statistically efficient summary on symmetric data."

#Playground("Sampling Distribution of the Median") {

    var rng = SeededRandomNumberGenerator(seed: 42)
    let population = [Double].randomNormal(10_000, mean: 100.0,
                                           standardDeviation: 15.0,
                                           using: &rng)

    // Draw 1,000 samples of size 50 and record the mean and median of each
    let means = population.samplingDistributionOfMean(
        sampleSize: 50, iterations: 1000, seed: 42)
    let medians = population.samplingDistributionOfMedian(
        sampleSize: 50, iterations: 1000, seed: 42)

    print("population mean:   \(String(format: "%.3f", population.mean() ?? 0))")
    print()
    print("Distribution of sample means (n = 50):")
    print("  mean: \(String(format: "%.3f", means.mean() ?? 0))")
    print("  std:  \(String(format: "%.3f", means.standardDeviation() ?? 0))")
    print()
    print("Distribution of sample medians (n = 50):")
    print("  mean: \(String(format: "%.3f", medians.mean() ?? 0))")
    print("  std:  \(String(format: "%.3f", medians.standardDeviation() ?? 0))")
    print()
    print("On symmetric data, the median's sampling distribution is wider —")
    print("the mean is the more efficient estimator here.")
}
