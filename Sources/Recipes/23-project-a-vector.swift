import Playgrounds
import Quiver

// Project a Vector onto Another
// Projection decomposes one vector into two parts:
// the component that lies along another vector (parallel)
// and the component perpendicular to it (orthogonal).
// Together they reconstruct the original exactly.

#Playground("Project a Vector onto Another") {

    // A force vector pushing at an angle
    let force = [5.0, 3.0]

    // The surface direction (a ramp tilted 30° from horizontal)
    let ramp = [1.0, 0.0]  // horizontal direction

    // How much force pushes along the ramp?
    // scalarProjection: the length of the shadow cast onto the ramp
    let along = force.scalarProjection(onto: ramp)  // 5.0
    print("Scalar projection (length): \(along)")

    // vectorProjection: the actual vector component along the ramp
    let parallel = force.vectorProjection(onto: ramp)  // [5.0, 0.0]

    // What's left over? The perpendicular component
    // This is the force pushing into (or away from) the ramp surface
    let perp = force.orthogonalComponent(to: ramp)  // [0.0, 3.0]

    // Verify: parallel + perpendicular = original force
    let reconstructed = parallel.add(perp)  // [5.0, 3.0]

    print("Force:         \(force)")
    print("Along ramp:    \(parallel)")     // [5.0, 0.0]
    print("Into ramp:     \(perp)")         // [0.0, 3.0]
    print("Reconstructed: \(reconstructed)")  // [5.0, 3.0]
    print("Match? \(force == reconstructed)")  // true
}
