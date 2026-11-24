// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Estimate a 95% interval from the 2.5th and 97.5th percentiles of
// the bootstrap statistics. This example resamples observations independently.

#Playground("Confidence Intervals with the Bootstrap") {
    // Skewed sample: most incomes cluster low, a few are very high
    let incomes = [38.0, 42.0, 45.0, 48.0, 51.0, 54.0, 57.0, 60.0,
                   62.0, 65.0, 68.0, 75.0, 92.0, 130.0, 220.0]

    let pointMean   = incomes.mean()   ?? 0.0
    let pointMedian = incomes.median() ?? 0.0
    print("Sample mean:   \(String(format: "%.1f", pointMean))")     // ≈ 73.8
    print("Sample median: \(String(format: "%.1f", pointMedian))")   // 60.0

    // Bootstrap the mean — 1,000 resamples, fixed seed
    let resampledMeans = incomes.resampled(iterations: 1000, seed: 42) {
        resample in resample.mean() ?? 0.0
    }

    // Bootstrap the median — the entire change is the closure.
    // The median is the better summary here: the mean is dragged
    // upward by a few large values.
    let resampledMedians = incomes.resampled(iterations: 1000, seed: 42) {
        resample in resample.median() ?? 0.0
    }

    // 95% percentile confidence intervals from each distribution
    guard let meanCI = resampledMeans.percentileCI(level: 0.95),
          let medianCI = resampledMedians.percentileCI(level: 0.95) else { return }

    print("95% CI for mean:   [\(String(format: "%.1f", meanCI.lower)), \(String(format: "%.1f", meanCI.upper))]")
    print("95% CI for median: [\(String(format: "%.1f", medianCI.lower)), \(String(format: "%.1f", medianCI.upper))]")

    // Recipe 65 shows a t interval under independent normal sampling.
}
