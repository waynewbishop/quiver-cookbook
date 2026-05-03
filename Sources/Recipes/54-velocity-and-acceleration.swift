import Playgrounds
import Quiver
import Foundation

// Velocity and Acceleration
// Position, velocity, and acceleration are linked by calculus:
// velocity is the derivative of position, acceleration is the
// derivative of velocity. Fitting a polynomial to noisy position
// samples gives a smooth model of motion, and `derivative()` on
// that polynomial returns the velocity polynomial — analytically,
// not numerically. Take the derivative once more and we have
// acceleration. This is what raw `LinearRegression` cannot do.

#Playground("Velocity and Acceleration") {

    // Position samples from a falling object: s(t) = 0.5·g·t²
    // with g = 9.8 m/s², measured at one-second intervals
    let t = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]
    let s = [0.0, 4.9, 19.6, 44.1, 78.4, 122.5]

    // Fit a degree-2 polynomial to the position samples
    guard let position = [Double].polyfit(x: t, y: s, degree: 2) else { return }

    let velocity = position.derivative()       // ds/dt
    let acceleration = velocity.derivative()   // d²s/dt²

    print("Position:     \(position)")     // 4.9t²
    print("Velocity:     \(velocity)")     // 9.8t
    print("Acceleration: \(acceleration)") // 9.8

    // Evaluate at t = 3 seconds
    print("At t = 3 s:")
    print("  position     = \(String(format: "%.1f", position(3))) m")        // ≈ 44.1
    print("  velocity     = \(String(format: "%.1f", velocity(3))) m/s")      // ≈ 29.4
    print("  acceleration = \(String(format: "%.1f", acceleration(3))) m/s²") // ≈ 9.8
}
