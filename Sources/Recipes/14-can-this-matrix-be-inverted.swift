// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Playgrounds
import Quiver

// Quiver rejects matrices whose rows are numerically dependent.

#Playground("Can This Matrix Be Inverted?") {
    // A 2×2 matrix with a non-zero determinant
    let matrix: [[Double]] = [
        [4.0, 7.0],
        [2.0, 6.0]
    ]

    let determinant = matrix.determinant
    print("Determinant: \(determinant)")

    if let inverse = try? matrix.inverted() {
        print("A⁻¹ = \(inverse)")

        // The product should be the identity up to rounding.
        let identity = matrix.multiplyMatrix(inverse)
        print("A × A⁻¹ = \(identity)")
        // [[1.0, 0.0], [0.0, 1.0]] — confirmed
    }

    // A singular matrix (determinant = 0) cannot be inverted
    // This matrix collapses 2D space into a line — information is lost
    let singular: [[Double]] = [[1.0, 2.0], [2.0, 4.0]]
    print("Singular det = \(singular.determinant)")  // 0.0
    print("Invertible?   \((try? singular.inverted()) != nil)")  // false

    // Floating-point rows can be too close to dependent to invert reliably.
    let nearlyDependent = [[1.0, 1.0], [1.0, 1.0 + Double.ulpOfOne]]
    print("Near-singular determinant: \(nearlyDependent.determinant)")
    do {
        _ = try nearlyDependent.inverted()
        print("Inverse computed")
    } catch {
        print("Inversion failed: \(error)")
    }
}
