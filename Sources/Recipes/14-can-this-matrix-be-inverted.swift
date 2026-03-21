import Playgrounds
import Quiver

// Can This Matrix Be Inverted?
// A matrix inverse "undoes" the original transformation.
// A × A⁻¹ = Identity (the "do nothing" matrix).
// If the determinant is zero, the matrix is singular — no inverse exists.

#Playground("Can This Matrix Be Inverted?") {

    // A 2×2 matrix with a non-zero determinant
    let A: [[Double]] = [
        [4.0, 7.0],
        [2.0, 6.0]
    ]

    // Step 1: Check the determinant
    // det = (4×6) - (7×2) = 24 - 14 = 10
    let det = A.determinant  // 10.0 — non-zero, so inverse exists
    print("Determinant: \(det)")

    // Step 2: Compute the inverse
    if let inv = try? A.inverted() {
        print("A⁻¹ = \(inv)")

        // Step 3: Verify — A × A⁻¹ should equal the identity matrix
        // The identity matrix is [[1, 0], [0, 1]] — it changes nothing
        let identity = A.multiplyMatrix(inv)
        print("A × A⁻¹ = \(identity)")
        // [[1.0, 0.0], [0.0, 1.0]] — confirmed
    }

    // A singular matrix (determinant = 0) cannot be inverted
    // This matrix collapses 2D space into a line — information is lost
    let singular: [[Double]] = [[1.0, 2.0], [2.0, 4.0]]
    print("Singular det = \(singular.determinant)")  // 0.0
    print("Invertible?   \((try? singular.inverted()) != nil)")  // false
}
