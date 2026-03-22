import Playgrounds
import Quiver

// Element-Wise Math
// Mathematical functions applied to every element of an array
// at once — no loops, no map closures. The same operations
// that power activation functions, signal processing, and
// scientific computing.

#Playground("Element-Wise Math") {

    let values = [1.0, 2.0, 3.0, 4.0]

    // Powers and roots
    let squared = values.power(2)        // [1, 4, 9, 16]
    let roots = values.sqrt()            // [1.0, 1.41, 1.73, 2.0]
    print("Squared: \(squared)")
    print("Roots:   \(roots.map { String(format: "%.2f", $0) })")

    // Exponentials and logarithms
    // exp(x) and log(x) are inverses — log(exp(x)) = x
    let exponentials = values.exp()      // [2.72, 7.39, 20.09, 54.60]
    let logs = values.log()              // [0.0, 0.69, 1.10, 1.39]
    let roundTrip = values.exp().log()   // [1.0, 2.0, 3.0, 4.0] — back to original
    print("exp:     \(exponentials.map { String(format: "%.2f", $0) })")
    print("log:     \(logs.map { String(format: "%.2f", $0) })")
    print("Round trip: \(roundTrip.map { String(format: "%.1f", $0) })")

    // Trigonometry — input in radians
    let angles = [0.0, .pi / 6, .pi / 4, .pi / 2]  // 0°, 30°, 45°, 90°
    let sines = angles.sin()             // [0.0, 0.5, 0.71, 1.0]
    let cosines = angles.cos()           // [1.0, 0.87, 0.71, 0.0]
    print("sin: \(sines.map { String(format: "%.2f", $0) })")
    print("cos: \(cosines.map { String(format: "%.2f", $0) })")
}
