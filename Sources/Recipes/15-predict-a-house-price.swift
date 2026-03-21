import Playgrounds
import Quiver

// Predict a House Price
// Linear regression finds the line (or plane) of best fit
// through data points. It learns coefficients that minimize
// the error between predicted and actual values.

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

    // Fit the model — finds coefficients via the normal equation
    let model = try! LinearRegression.fit(features: features, targets: prices)

    // Predict: what would a 1800 sqft, 3 bed, 6 year old house sell for?
    let prediction = model.predict([[1800.0, 3.0, 6.0]])

    // How well does the model fit? R² = 1.0 is perfect, 0.0 is no fit
    let predicted = model.predict(features)
    let r2 = predicted.rSquared(actual: prices)

    print("Predicted price: $\(String(format: "%.1f", prediction[0]))K")
    print("R² score: \(String(format: "%.4f", r2))")
}
