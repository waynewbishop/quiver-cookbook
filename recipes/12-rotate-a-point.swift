import Playgrounds
import Quiver

// Rotate a Point 90 Degrees
// A rotation matrix spins a vector around the origin without
// changing its length. The matrix columns tell you where the
// basis vectors (x-axis and y-axis) end up after rotation.

#Playground("Rotate a Point 90 Degrees") {

    // 90° counterclockwise rotation matrix
    // Column 1: x-axis [1,0] moves to [0,1] (points up)
    // Column 2: y-axis [0,1] moves to [-1,0] (points left)
    let rotate90 = [[0.0, -1.0],
                     [1.0,  0.0]]

    // A point in the first quadrant (x positive, y positive)
    let point = [3.0, 4.0]

    // Apply the rotation: matrix × vector
    // Row 0: (0×3) + (-1×4) = -4
    // Row 1: (1×3) + (0×4)  =  3
    let rotated = rotate90.transform(point)  // [-4.0, 3.0]

    // The point moved to the second quadrant — rotated 90° CCW
    // Length is preserved: √(3² + 4²) = √(-4² + 3²) = 5.0
    let before = point.magnitude    // 5.0
    let after = rotated.magnitude   // 5.0

    print("Before: \(point) — magnitude \(before)")
    print("After:  \(rotated) — magnitude \(after)")
    print("Length preserved? \(before == after)")  // true
}
