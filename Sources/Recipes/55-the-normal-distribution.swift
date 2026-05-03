import Playgrounds
import Quiver
import Foundation

// The Normal Distribution: PDF, CDF, and Quantiles
// `Distributions.normal` exposes the three textbook functions of
// the normal distribution as a stateless namespace. The PDF gives
// the density at a point, the CDF gives the cumulative probability
// up to a point, and the quantile function inverts the CDF — given
// a probability, it returns the value that puts that probability
// below it. All three return `Double?` and produce `nil` for
// out-of-domain inputs (negative `std`, `p` outside `(0, 1)`).

#Playground("The Normal Distribution") {

    // Standard normal: mean = 0, std = 1
    let mean = 0.0
    let std  = 1.0

    // Density at five points along the curve
    let xs = [-2.0, -1.0, 0.0, 1.0, 2.0]
    print("PDF values along the curve:")
    for x in xs {
        let density = Distributions.normal.pdf(x: x, mean: mean, std: std) ?? 0
        print("  pdf(\(x)) = \(String(format: "%.4f", density))")
    }
    // pdf(0) ≈ 0.3989 is the peak; symmetric tails fall off

    // Cumulative probability — area under the curve up to x
    let p975 = Distributions.normal.cdf(x: 1.96, mean: mean, std: std) ?? 0
    let p50  = Distributions.normal.cdf(x: 0.0,  mean: mean, std: std) ?? 0
    print("P(Z ≤ 1.96) = \(String(format: "%.4f", p975))")  // ≈ 0.9750
    print("P(Z ≤ 0.00) = \(String(format: "%.4f", p50))")   // ≈ 0.5000

    // Quantile — the inverse: which z-value puts p below it?
    let z975 = Distributions.normal.quantile(p: 0.975, mean: mean, std: std) ?? 0
    print("z at p = 0.975 → \(String(format: "%.4f", z975))")  // ≈ 1.9600

    // Out-of-domain input returns nil rather than crashing
    let bad = Distributions.normal.pdf(x: 0, mean: 0, std: -1)
    print("std = -1 → \(bad as Any)")  // nil
}
