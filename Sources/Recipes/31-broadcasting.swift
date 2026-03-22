import Playgrounds
import Quiver

// Broadcasting
// Broadcasting applies a scalar operation to every element in
// an array without writing a loop. The result reads like a
// mathematical formula — the code IS the equation.

#Playground("Broadcasting") {

    // Fahrenheit to Celsius — the formula: C = (F - 32) × 5/9
    // Broadcasting lets us write it exactly as math notation
    let fahrenheit = [32.0, 68.0, 72.0, 98.6, 212.0]
    let celsius = (fahrenheit - 32.0) * (5.0 / 9.0)
    print("°F: \(fahrenheit)")
    print("°C: \(celsius.map { String(format: "%.1f", $0) })")

    // Scalar operations work in both directions
    let prices = [10.0, 25.0, 50.0, 75.0]
    let withTax = prices * 1.08          // multiply each by 1.08
    let discounted = prices - 5.0        // subtract $5 from each
    let doubled = 2.0 * prices           // scalar on the left works too
    print("With tax:    \(withTax)")
    print("Discounted:  \(discounted)")
    print("Doubled:     \(doubled)")

    // Z-score standardization — how many standard deviations
    // each value sits from the mean
    let scores = [72.0, 85.0, 91.0, 68.0, 95.0]
    let mean = scores.mean()!
    let std = scores.std()!
    let zScores = (scores - mean) / std
    print("Z-scores: \(zScores.map { String(format: "%.2f", $0) })")
}
