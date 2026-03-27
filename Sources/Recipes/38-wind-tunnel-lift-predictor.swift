import Playgrounds
import Quiver

// Wind Tunnel Lift Predictor
// In aerodynamics, a wing's lift coefficient (CL) increases linearly
// with the angle of attack — the angle between the wing and the
// oncoming air. This linear relationship holds from about 0° to 12°,
// after which the wing stalls and lift drops sharply.
//
// NACA tested hundreds of airfoil shapes in wind tunnels and
// published the data. The slope of CL vs angle of attack is
// approximately 0.11 per degree for a typical airfoil — meaning
// every degree of tilt adds about 0.11 to the lift coefficient.
//
// This recipe uses LinearRegression on simulated wind tunnel
// measurements to learn that relationship, then predicts the lift
// coefficient at angles the tunnel hasn't tested. The same fit()
// that predicts house prices also predicts whether a wing flies.

#Playground("Wind Tunnel Lift Predictor") {

    // Simulated wind tunnel readings for a NACA 2412 airfoil
    // Angle of attack (degrees) → measured lift coefficient
    let angle =  [0.0,  2.0,  4.0,  6.0,  8.0, 10.0]
    let liftCL = [0.25, 0.47, 0.69, 0.90, 1.10, 1.30]

    // Train a regression model on the wind tunnel data
    let model = try LinearRegression.fit(features: angle, targets: liftCL)
    print(model)

    // Predict lift at an angle the tunnel hasn't tested
    let predicted = model.predict([7.0])
    print("Angle: 7° → CL: \(String(format: "%.2f", predicted[0]))")

    // How well does the linear model fit?
    let r2 = model.predict(angle).rSquared(actual: liftCL)
    print("R²: \(String(format: "%.4f", r2))")
}
