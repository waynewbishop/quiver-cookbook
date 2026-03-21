import Playgrounds
import Quiver

// Normalize a Direction
// Normalization separates "how much" from "which way."
// A unit vector has length 1 and points in the same direction.

#Playground("Normalize a Direction") {

    // A velocity vector: 3 units east, 4 units north
    let velocity = [3.0, 4.0]
    let speed = velocity.magnitude  // 5.0 (the "how much")
    print("Speed: \(speed)")

    // Normalize: divide each component by the magnitude
    // [3/5, 4/5] = [0.6, 0.8] — same direction, length = 1.0
    let direction = velocity.normalized  // [0.6, 0.8]

    // Verify: the unit vector's magnitude is exactly 1.0
    let check = direction.magnitude  // 1.0

    // Why this matters: now we can apply any speed we want.
    // Move in this direction at 10 units per second:
    let newSpeed = 10.0
    let newVelocity = direction.map { $0 * newSpeed }  // [6.0, 8.0]

    // The new velocity has magnitude 10.0, same direction as original
    let verifySpeed = newVelocity.magnitude  // 10.0

    print("Direction: \(direction)")        // [0.6, 0.8]
    print("Unit length: \(check)")          // 1.0
    print("At speed 10: \(newVelocity)")    // [6.0, 8.0]
    print("New speed: \(verifySpeed)")      // 10.0
}
