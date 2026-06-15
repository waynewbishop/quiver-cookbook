import Playgrounds
import Quiver
import Foundation

// One-Sample t-Test
// We hypothesize the class mean is 12. A new sample of 12 students
// scored {12, 14, 11, ...}. Is our sample mean far enough from 12
// to reject the hypothesis, or could the gap be sampling noise?
// The one-sample t-test answers this by combining the sample mean,
// the standard error, and the t-distribution's cumulative
// probability into a single p-value.

#Playground("One-Sample t-Test") {

    let scores = [12.0, 14.0, 11.0, 13.0, 15.0, 9.0,
                  11.0, 13.0, 16.0, 12.0, 10.0, 14.0]
    let mu0 = 12.0  // hypothesized population mean

    let n = scores.count
    let degreesOfFreedom = Double(n - 1)

    guard let xbar = scores.mean(),
          let se = scores.standardError() else {
        return
    }

    // The t-statistic: how many standard errors away from mu0?
    let t = (xbar - mu0) / se

    // Two-tailed p-value via the t-distribution CDF
    let absT = t < 0 ? -t : t
    guard let upperTail = Distributions.t.cdf(x: absT, df: degreesOfFreedom) else {
        return
    }
    let pValue = 2.0 * (1.0 - upperTail)

    print("sample mean:   \(String(format: "%.4f", xbar))")
    print("standard err:  \(String(format: "%.4f", se))")
    print("t-statistic:   \(String(format: "%.4f", t))")
    print("p-value:       \(String(format: "%.4f", pValue))")  // ~0.42 — not significant
    print()
    print(pValue < 0.05
        ? "Reject H0 — the mean is distinguishable from \(mu0)."
        : "Cannot reject H0 — the gap is consistent with sampling noise.")
}
