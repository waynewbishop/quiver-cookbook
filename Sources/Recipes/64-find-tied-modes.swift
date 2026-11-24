// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Find Tied Modes with mode()
// mode() returns every value tied for highest sample frequency,
// in order of first appearance. A histogram shows the overall shape.

#Playground("Find Tied Modes with mode()") {
    // Mixing two populations: shorter and taller groups
    let heights: [Double] = [
        180, 178, 180, 179, 181, 180, 178, 180,     // taller group
        162, 164, 162, 163, 162, 165, 164, 162      // shorter group
    ]

    let modes = heights.mode()
    print("Modes: \(modes)")  // [180.0, 162.0] — in first-appearance order

    if modes.count > 1 {
        print("\(modes.count) values share the highest sample frequency.")
    }

    // The histogram makes the two-cluster shape visible
    print()
    print("Histogram:")
    for bin in heights.histogram(bins: 8) {
        let bar = String(repeating: "█", count: bin.count)
        print("  \(String(format: "%6.1f", bin.midpoint)): \(bar) (\(bin.count))")
    }
}
