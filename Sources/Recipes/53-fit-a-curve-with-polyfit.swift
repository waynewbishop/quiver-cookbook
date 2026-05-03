import Playgrounds
import Quiver
import Foundation

// Fit a Curve with polyfit
// Linear regression draws a straight line through points. polyfit
// extends the same idea to nonlinear shapes by fitting a polynomial
// of any degree. Internally it builds a Vandermonde-style design
// matrix and defers to LinearRegression, so polynomial fitting and
// the regression model agree by construction. The returned
// Polynomial value type evaluates with `callAsFunction` and
// stores its coefficients in ascending order — the constant term
// first.

#Playground("Fit a Curve with polyfit") {

    // Points sampled from y = 2x² + 3x + 1 (degree 2)
    let x = [1.0, 2.0, 3.0, 4.0, 5.0]
    let y = [6.0, 15.0, 28.0, 45.0, 66.0]

    // Fit a degree-2 polynomial; polyfit returns Polynomial?
    guard let p = [Double].polyfit(x: x, y: y, degree: 2) else { return }

    // Coefficients are ascending: [constant, linear, quadratic]
    print("Coefficients: \(p.coefficients)")  // ≈ [1.0, 3.0, 2.0]
    print("Polynomial:   \(p)")               // 2x² + 3x + 1

    // Evaluate the fitted polynomial at new x values
    print("p(6) = \(p(6))")    // ≈ 91.0
    print("p(10) = \(p(10))")  // ≈ 231.0

    // Vectorized evaluation works the same way
    let grid = [0.0, 0.5, 1.5, 2.5]
    print("p(grid) = \(p(grid))")  // ≈ [1.0, 3.0, 10.0, 21.0]
}
