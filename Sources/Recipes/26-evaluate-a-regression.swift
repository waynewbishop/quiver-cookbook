import Playgrounds
import Quiver

// Evaluate a Regression Model
// A classifier predicts categories — right or wrong. A regression
// model predicts numbers — so we measure how far off the predictions
// are. Three metrics tell different parts of the story.

#Playground("Evaluate a Regression Model") {

    // Predicted house prices (in thousands) vs actual sale prices
    let predicted = [250.0, 310.0, 275.0, 305.0, 195.0, 285.0, 335.0, 360.0]
    let actual    = [245.0, 312.0, 279.0, 308.0, 199.0, 289.0, 340.0, 365.0]

    // R² (R-squared): how much of the variation does our model explain?
    // 1.0 = perfect fit, 0.0 = no better than predicting the mean every time
    let r2 = predicted.rSquared(actual: actual)

    // MSE (Mean Squared Error): average of squared differences
    // Penalizes large errors heavily — a $20K miss counts 4× more than a $10K miss
    let mse = predicted.meanSquaredError(actual: actual)

    // RMSE (Root Mean Squared Error): square root of MSE
    // Back in the original units ($K) — easier to interpret
    // "On average, our predictions are off by about $X thousand"
    let rmse = predicted.rootMeanSquaredError(actual: actual)

    print("R²:   \(String(format: "%.4f", r2))")
    print("MSE:  \(String(format: "%.2f", mse))")
    print("RMSE: $\(String(format: "%.2f", rmse))K")
}
