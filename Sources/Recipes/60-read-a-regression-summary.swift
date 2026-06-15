import Playgrounds
import Quiver

// Read a Regression Summary
// A fitted regression has more to tell us than a single R². For
// every coefficient, summary() reports its standard error, a
// t-statistic (how many SEs the estimate sits from zero), a
// two-tailed p-value, and a 95% confidence interval. Together
// these answer the question "is this slope real, or could it
// be noise?" — the inferential heart of regression.

#Playground("Read a Regression Summary") {

    // Hours studied → final exam score
    let features: [[Double]] = [
        [1.0], [2.0], [3.0], [4.0], [5.0],
        [6.0], [7.0], [8.0], [9.0], [10.0]
    ]
    let scores = [55.0, 60.0, 66.0, 71.0, 75.0, 80.0, 84.0, 89.0, 93.0, 98.0]

    let model = try LinearRegression.fit(features: features, targets: scores)
    let report = try model.summary(features: features, targets: scores)

    // The full structured summary — coefficients, t-stats, p-values, CIs
    print(report)

    // Programmatic access to the inferential fields
    print("R²: \(String(format: "%.4f", report.rSquared))")
    print("Intercept t-statistic: \(String(format: "%.2f", report.tStatistics[0]))")
    print("Slope t-statistic:     \(String(format: "%.2f", report.tStatistics[1]))")
    print("Slope p-value:         \(String(format: "%.6f", report.pValues[1]))")

    // The 95% confidence interval for the slope — if it excludes zero,
    // the relationship is statistically distinguishable from noise
    let ci = report.confidenceIntervals[1]
    print("Slope 95% CI: [\(String(format: "%.3f", ci.lower)), \(String(format: "%.3f", ci.upper))]")
}
