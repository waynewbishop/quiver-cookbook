import Playgrounds
import Quiver
import Foundation

// Pipeline for Linear Regression
// Pipelines work for regression as well as classification. The
// LinearRegression overload follows the Regressor protocol added
// in 1.1.0 — the scaler is fit on the training features, the
// regression coefficients are learned on the scaled inputs, and
// the bundle persists as one Codable value. The regression
// overload throws when features are linearly dependent, so we
// wrap the call in `try`.

#Playground("Pipeline for Linear Regression") {

    // Inline housing data: [square feet, bedrooms, age in years]
    let features: [[Double]] = [
        [1400, 3, 10], [1600, 3, 5], [1700, 4, 8], [1875, 4, 3],
        [1100, 2, 15], [1550, 3, 7], [2350, 4, 2], [2450, 5, 1]
    ]
    let prices = [245.0, 312.0, 279.0, 308.0, 199.0, 289.0, 340.0, 365.0]

    // Fit scaler + LinearRegression in one call (throws on singular features)
    let pipeline = try Pipeline.fit(features: features, targets: prices)

    // Predict on raw, unscaled inputs — Pipeline scales internally
    let prediction = pipeline.predict([[1800.0, 3.0, 6.0]])
    print("Predicted: $\(String(format: "%.1f", prediction[0]))K")

    // Round-trip through JSON: scaler and model travel as one value
    let data = try JSONEncoder().encode(pipeline)
    let restored = try JSONDecoder().decode(
        Pipeline<LinearRegression>.self, from: data
    )
    print(pipeline == restored)  // true
}
