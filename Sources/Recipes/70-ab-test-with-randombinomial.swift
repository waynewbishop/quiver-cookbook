import Playgrounds
import Quiver

// A/B Test with randomBinomial
// Variant A converts at 4%. Variant B converts at 5%. With 1,000
// visitors per variant, will we reliably see the difference, or
// will it get lost in sampling noise? Simulate the experiment
// many times by drawing from a binomial distribution and counting
// how often B beats A.

#Playground("A/B Test Simulation") {

    var rng = SeededRandomNumberGenerator(seed: 1234)

    let visitorsPerVariant = 1000
    let conversionRateA = 0.04
    let conversionRateB = 0.05

    // Simulate 500 experiments. Each draws one binomial outcome per variant.
    let experiments = 500
    let aConversions = [Double].randomBinomial(experiments,
                                               n: visitorsPerVariant,
                                               p: conversionRateA,
                                               using: &rng)
    let bConversions = [Double].randomBinomial(experiments,
                                               n: visitorsPerVariant,
                                               p: conversionRateB,
                                               using: &rng)

    // How often did B actually beat A?
    let bWins = zip(aConversions, bConversions).filter { $1 > $0 }.count
    let rate = Double(bWins) / Double(experiments)

    print("True conversion rates: A = \(conversionRateA), B = \(conversionRateB)")
    print("Visitors per variant: \(visitorsPerVariant)")
    print("Experiments simulated: \(experiments)")
    print()
    print("Mean conversions A: \(String(format: "%.2f", aConversions.mean() ?? 0))")
    print("Mean conversions B: \(String(format: "%.2f", bConversions.mean() ?? 0))")
    print()
    print("B beat A in \(bWins) of \(experiments) experiments (\(String(format: "%.1f%%", rate * 100)))")
    print()
    print("Even though B's true rate is higher, the gap is small relative")
    print("to the sampling noise — running just one experiment can mislead.")
}
