// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Inter-Arrival Times with randomExponential
// A homogeneous Poisson process has independent exponential gaps
// at a constant arrival rate. The expected gap is 1/rate.

#Playground("Inter-Arrival Times") {
    var rng = SeededRandomNumberGenerator(seed: 31)

    // Suppose API requests arrive at 5 per second on average.
    // The gap between requests is exponential with rate = 5.0,
    // so the mean inter-arrival time is 1/5 = 0.2 seconds.
    let rate = 5.0
    let gaps = [Double].randomExponential(20, rate: rate, using: &rng)

    print("Inter-arrival times (seconds):")
    for (i, gap) in gaps.enumerated() {
        print("  request \(i + 1): \(String(format: "%.4f", gap))s")
    }
    print()
    print("observed mean gap: \(String(format: "%.4f", gaps.mean() ?? 0))s")
    print("expected mean gap: \(String(format: "%.4f", 1.0 / rate))s")
    print()
    // Compare typical remaining waits after already waiting 0.2 seconds.
    let sample = [Double].randomExponential(10_000, rate: rate, using: &rng)
    let cutoff = 0.2
    let remaining = sample.filter { $0 > cutoff }.map { $0 - cutoff }
    print("Mean remaining wait after \(cutoff)s: \(remaining.mean() ?? 0)s")
    print("Mean wait from the start: \(sample.mean() ?? 0)s")
}
