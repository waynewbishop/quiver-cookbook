import Playgrounds
import Quiver

// Predict a House Price
// Linear regression finds the best-fit plane through data points.
// Internally it solves the normal equation: (X'X)⁻¹X'y — which
// chains four operations from the matrix recipes: transpose (Recipe 13),
// multiply, invert (Recipe 14), and transform. The same linear algebra
// that rotates points and solves systems of equations also learns
// coefficients that minimize prediction error.

#Playground("Predict a House Price") {

    // Training data: [square feet, bedrooms, age in years]
    let features: [[Double]] = [
        [1400, 3, 10],
        [1600, 3, 5],
        [1700, 4, 8],
        [1875, 4, 3],
        [1100, 2, 15],
        [1550, 3, 7],
        [2350, 4, 2],
        [2450, 5, 1]
    ]

    // Actual sale prices (in thousands)
    let prices = [245.0, 312.0, 279.0, 308.0, 199.0, 289.0, 340.0, 365.0]

    // Fit the model — solves the normal equation using the same
    // matrix operations from Recipes 13-14: transpose, multiply, invert
    if let model = try? LinearRegression.fit(features: features, targets: prices) {
        print(model)  // LinearRegression: 3 features, intercept: ..., weights: [...]

        // Predict: what would a 1800 sqft, 3 bed, 6 year old house sell for?
        let prediction = model.predict([[1800.0, 3.0, 6.0]])
        print("Predicted price: $\(String(format: "%.1f", prediction[0]))K")

        // summary() returns a typed RegressionSummary with R², MSE, RMSE,
        // plus t-statistics, p-values, and 95% confidence intervals for
        // every coefficient. The full inferential picture in one call.
        if let report = try? model.summary(features: features, targets: prices) {
            print(report)
        }
    }
}
