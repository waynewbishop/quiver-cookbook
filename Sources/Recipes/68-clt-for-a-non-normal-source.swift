import Playgrounds
import Quiver

// Central Limit Theorem — for a Non-Normal Source
// The Central Limit Theorem holds even when the source population
// is wildly non-normal. Here the source is exponential — most values
// small, with a long right tail. The sample means are still normal,
// just with a different standard error than a normal source would
// give. This is the CLT's claim made physical.

#Playground("Central Limit Theorem — Non-Normal Source") {

    var rng = SeededRandomNumberGenerator(seed: 99)

    // Skewed source: rate = 0.5 → population mean is 1/0.5 = 2.0
    let population = [Double].randomExponential(10_000, rate: 0.5, using: &rng)

    print("Source (exponential, rate = 0.5):")
    print("  mean: \(String(format: "%.3f", population.mean() ?? 0))    (theoretical 2.0)")
    print("  std:  \(String(format: "%.3f", population.standardDeviation() ?? 0))")
    print()
    print("  Shape — heavily skewed right:")
    for bin in population.histogram(bins: 6) {
        let mid = String(format: "%5.2f", bin.midpoint)
        print("    \(mid): \(String(repeating: "█", count: bin.count / 80))")
    }
    print()

    // The CLT promise: sample means are normal even when the source isn't
    let sampleMeans = population.samplingDistributionOfMean(
        sampleSize: 100, iterations: 1000, seed: 42)

    print("Distribution of 1,000 sample means (n = 100):")
    print("  mean: \(String(format: "%.3f", sampleMeans.mean() ?? 0))   (matches the source mean)")
    print("  std:  \(String(format: "%.3f", sampleMeans.standardDeviation() ?? 0))   (this is the standard error)")
    print()
    print("  Shape — bell-curved, regardless of the skewed source:")
    for bin in sampleMeans.histogram(bins: 7) {
        let mid = String(format: "%5.2f", bin.midpoint)
        print("    \(mid): \(String(repeating: "█", count: bin.count / 15))")
    }
}
