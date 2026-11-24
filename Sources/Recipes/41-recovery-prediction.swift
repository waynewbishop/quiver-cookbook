// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Use simulated workout summaries to estimate next-morning heart rate elevation.

#Playground("Recovery Prediction") {
    // Columns: score, fraction of time at threshold or harder, residual in bpm.
    let history: [[Double]] = [
        [45,  0.00,  0.5],   // easy
        [72,  0.05,  1.0],   // long easy
        [88,  0.35,  0.0],   // threshold session
        [64,  0.20,  1.5],   // hilly mixed
        [105, 0.55,  2.0],   // hard intervals
        [38,  0.00, -0.5],   // recovery jog
        [80,  0.15,  6.0],   // steady run, hot afternoon
        [96,  0.40,  4.5],   // hard trail with a long descent, warm
    ]

    // Next-morning resting HR elevation (BPM above baseline)
    let heartRateElevation = [1.5, 3.5, 4.5, 4.0, 8.0, 1.0, 5.5, 7.5]

    // Train on the relationship between the TES breakdown and recovery cost
    let model = try LinearRegression.fit(features: history, targets: heartRateElevation)
    print(model)

    // Today's run: TES 85, 30% of the time at threshold or harder
    let todaysRun = [[85.0, 0.30, 1.0]]
    let prediction = model.predict(todaysRun)
    print("Predicted HR elevation: +\(String(format: "%.0f", prediction[0])) BPM")   // +5

    // Hold score and effort constant while changing the residual.
    let hotRun = [[85.0, 0.30, 7.0]]
    let hotPrediction = model.predict(hotRun)
    print("Same TES, hot day:      +\(String(format: "%.0f", hotPrediction[0])) BPM")   // +7

    // Inspect the coefficient uncertainty for this small fixture.
    let report = try model.summary(features: history, targets: heartRateElevation)
    print(report)
}
