// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Playgrounds
import Quiver

// Gaussian Naive Bayes estimates each feature’s mean and variance by class.
// See Recipe 82 for binary features.

#Playground("Classify with Gaussian Naive Bayes") {
    // Weather data: [temperature °F, humidity %]
    // Class 0 = no rain, Class 1 = rain
    let features: [[Double]] = [
        [85.0, 30.0], [90.0, 25.0], [78.0, 40.0], [82.0, 35.0],  // no rain
        [65.0, 85.0], [60.0, 90.0], [68.0, 80.0], [62.0, 88.0]   // rain
    ]
    let labels = [0, 0, 0, 0, 1, 1, 1, 1]

    let model = GaussianNaiveBayes.fit(features: features, labels: labels)

    // Inspect the fitted class priors and feature means.
    print(model)  // GaussianNaiveBayes: 2 classes, 2 features
    for classSummary in model.classes {
        print(classSummary)
    }

    // Group new observations by their predicted label.
    let forecast: [[Double]] = [[80.0, 38.0], [63.0, 82.0], [75.0, 45.0]]
    let results = model.classify(forecast)

    let classNames = ["No Rain", "Rain"]
    for group in results {
        print("\(classNames[group.label]): \(group.count) forecasts")
        for point in group {
            print("  temp: \(point[0])°F, humidity: \(point[1])%")
        }
    }
}
