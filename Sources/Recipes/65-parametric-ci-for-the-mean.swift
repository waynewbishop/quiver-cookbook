// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Parametric CI for the Mean
// Under independent normal sampling, the standardized sample mean
// using the estimated standard error follows a t distribution.

#Playground("Parametric CI for the Mean") {
    // Daily API response times (ms)
    let times: [Double] = [42, 45, 47, 43, 46, 44, 48, 42, 45, 46]

    let n = times.count
    let degreesOfFreedom = Double(n - 1)

    guard let mean = times.mean(),
          let se = times.standardError(),
          let tCrit = Distributions.t.quantile(p: 0.975, df: degreesOfFreedom) else {
        return
    }

    let margin = tCrit * se
    let lower = mean - margin
    let upper = mean + margin

    print("n:             \(n)")
    print("sample mean:   \(String(format: "%.3f", mean))")          // 44.8
    print("standard err:  \(String(format: "%.3f", se))")            // ~0.65
    print("t critical:    \(String(format: "%.3f", tCrit))")         // ~2.26
    print()
    print("95% CI for the mean: [\(String(format: "%.3f", lower)), \(String(format: "%.3f", upper))]")
}
