import Playgrounds
import Quiver

// Are These Perpendicular?
// The dot product reveals angle relationships between vectors.
// Positive = same direction, zero = perpendicular, negative = opposite.

#Playground("Are These Perpendicular?") {

    // Case 1: Same direction — dot product is positive
    // Both vectors point to the upper-right
    let a1 = [3.0, 4.0]
    let b1 = [6.0, 8.0]
    let same = a1.dot(b1)  // 50.0 (positive → similar direction)

    // Case 2: Perpendicular — dot product is zero
    // One points right, one points up — 90° angle between them
    let a2 = [1.0, 0.0]
    let b2 = [0.0, 1.0]
    let perp = a2.dot(b2)  // 0.0 (zero → perpendicular)

    // Case 3: Opposite direction — dot product is negative
    // One points right, one points left — 180° apart
    let a3 = [1.0, 0.0]
    let b3 = [-1.0, 0.0]
    let opp = a3.dot(b3)  // -1.0 (negative → opposite)

    // We can also get the exact angle in degrees
    let angle1 = a1.angleInDegrees(with: b1)  // ~0° (parallel)
    let angle2 = a2.angleInDegrees(with: b2)  // 90° (perpendicular)
    let angle3 = a3.angleInDegrees(with: b3)  // 180° (opposite)

    print("Same direction:  dot = \(same), angle = \(angle1)°")
    print("Perpendicular:   dot = \(perp), angle = \(angle2)°")
    print("Opposite:        dot = \(opp), angle = \(angle3)°")
}
