// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// A PDF gives curve height at a point. A CDF gives area to its left.
// Hypothesis tests use tail areas under the null distribution.

#Playground("From a Test Statistic to a Tail Probability") {
    // Recipe 62 reports a rounded absolute t statistic with 11 degrees of freedom.
    let t = 0.8379
    let tDF = 11.0

    // Recipe 63 reports chi-squared = 1 with 5 degrees of freedom.
    let chiSquared = 1.0
    let chiDF = 5.0

    guard let tDensity = Distributions.t.pdf(x: t, df: tDF),
          let tCDF = Distributions.t.cdf(x: t, df: tDF),
          let chiDensity = Distributions.chiSquared.pdf(x: chiSquared, df: chiDF),
          let chiCDF = Distributions.chiSquared.cdf(x: chiSquared, df: chiDF) else {
        return
    }

    // The t distribution is symmetric, so both tails contribute equally.
    print(String(format: "t density %.4f, two-sided p-value %.4f", tDensity, 2 * (1 - tCDF)))
    print(String(format: "Chi-squared density %.4f, right-tail p-value %.4f", chiDensity, 1 - chiCDF))
}
