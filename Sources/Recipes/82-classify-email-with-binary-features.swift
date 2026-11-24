// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Bernoulli Naive Bayes models binary features, such as whether an
// email contains an urgent phrase or comes from a known sender.
// Recipe 16 uses Gaussian Naive Bayes for continuous measurements.

#Playground("Classify Email with Binary Features") {
    // Columns: [contains urgent phrase, known sender]. Labels: 0 = ordinary, 1 = spam.
    let features: [[Double]] = [
        [0, 1], [0, 1], [1, 1], [0, 0],
        [1, 0], [1, 0], [1, 0], [0, 0]
    ]
    let model = BernoulliNaiveBayes.fit(features: features, labels: [0, 0, 0, 0, 1, 1, 1, 1])

    // No spam training example is from a known sender. Laplace smoothing
    // gives that event a probability of (0 + 1) / (4 + 2).
    if let spam = model.classes.first(where: { $0.label == 1 }) {
        let probability = spam.featureProbabilities[1]
        print("P(known sender | spam):", String(format: "%.3f", probability))
        print("P(unknown sender | spam):", String(format: "%.3f", 1 - probability))
    }

    // Hold the urgent phrase fixed. The presence or absence of a known
    // sender changes the posterior estimate and can change the label.
    let emails: [[Double]] = [[1, 1], [1, 0]]
    let probabilities = model.predictProbabilities(emails)
    print("Spam estimates:", probabilities.map { String(format: "%.3f", $0[1]) })
    print("Predicted labels:", model.predict(emails))
}
