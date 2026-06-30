import Playgrounds
import Quiver

// Analyze Regression Residuals
// A regression (Recipe 15) gives a prediction; the residual tells us
// how far that prediction missed. A residual is observed − expected,
// and reading residuals is the standard diagnostic step: small,
// patternless residuals mean the model captured the signal, while a
// large one flags a point the model could not explain. ResidualModel
// wraps any fitted regressor and reports the gap.

#Playground("Analyze Regression Residuals") {

    // Square footage → house price. The fit recovers a clean line;
    // one home sells well above what its size predicts.
    let sqft: [[Double]] = [[1000.0], [1500.0], [2000.0], [2500.0], [3000.0]]
    let prices = [150000.0, 200000.0, 260000.0, 310000.0, 410000.0]

    // Fit the baseline, then wrap it. ResidualModel trains nothing of
    // its own — it measures against the model we hand it.
    let baseline = try LinearRegression.fit(features: sqft, targets: prices)
    let diagnostic = ResidualModel(model: baseline)

    // expected() is the baseline's prediction; residuals() is the gap
    // per sample, observed − expected.
    let expected = diagnostic.expected(sqft)
    let gaps = diagnostic.residuals(features: sqft, targets: prices)
    for (e, g) in zip(expected, gaps) {
        print("expected \(String(format: "%.0f", e)) → residual \(String(format: "%+.0f", g))")
    }

    // A single new observation: how far did this sale beat its size?
    let surprise = diagnostic.residual(features: [3000.0], observed: 410000.0)
    print("3000 sqft surprise:", String(format: "%+.0f", surprise))
}
