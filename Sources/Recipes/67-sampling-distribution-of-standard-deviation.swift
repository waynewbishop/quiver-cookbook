import Playgrounds
import Quiver

// Sampling Distribution of the Standard Deviation
// Sample standard deviations have their own sampling distribution,
// which is skewed for small samples and noisier than the mean's.
// Watch the spread shrink — slowly — as the sample size grows.

#Playground("Sampling Distribution of the Standard Deviation") {

    var rng = SeededRandomNumberGenerator(seed: 7)
    let population = [Double].randomNormal(10_000, mean: 0.0,
                                           standardDeviation: 1.0,
                                           using: &rng)

    let sampleSizes = [10, 50, 200]
    for n in sampleSizes {
        let sds = population.samplingDistributionOfStandardDeviation(
            sampleSize: n, iterations: 1000, seed: 42)
        print("n = \(n):")
        print("  mean of sample SDs: \(String(format: "%.4f", sds.mean() ?? 0))")
        print("  spread of SDs:      \(String(format: "%.4f", sds.standardDeviation() ?? 0))")
    }
    print()
    print("True population SD = 1.0. As n grows, sample SDs cluster")
    print("more tightly around 1.0 — but slower than sample means.")
}
