// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Threshold Gaussian Naive Bayes Probabilities
// The model returns posterior estimates that sum to one for each sample.
// Calibration is a separate question about how those estimates match observed
// frequencies. Here we compare two decision thresholds.

#Playground("Threshold Gaussian Naive Bayes Probabilities") {
    // Two-class data: temperature readings → rain (1) or no rain (0)
    let features: [[Double]] = [
        [15], [18], [22], [25],
        [19], [22], [26], [29]
    ]
    let labels = [0, 0, 0, 0, 1, 1, 1, 1]
    let model = GaussianNaiveBayes.fit(features: features, labels: labels)

    // Probabilities for new samples — shape [samples × classes]
    let queries: [[Double]] = [[18], [23], [28]]
    let probs = model.predictProbabilities(queries)

    // Each row sums to 1.0 — the full distribution over classes
    for i in 0..<probs.count {
        let row = probs[i]
        let pNoRain = String(format: "%.3f", row[0])
        let pRain   = String(format: "%.3f", row[1])
        let total   = String(format: "%.3f", row[0] + row[1])
        print("query \(i): P(no rain) = \(pNoRain), P(rain) = \(pRain), sum = \(total)")
    }

    // Cost-sensitive decision: predict rain only when P(rain) > 0.7
    let threshold = 0.7
    let decisions = probs.map { $0[1] > threshold ? 1 : 0 }
    print("Decisions at P(rain) > 0.5: \(probs.map { $0[1] > 0.5 ? 1 : 0 })")
    print("Decisions at P(rain) > \(threshold): \(decisions)")
}
