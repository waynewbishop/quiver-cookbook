// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Playgrounds
import Quiver

// Classify with Logistic Regression
// Logistic regression fits coefficients by gradient descent on
// cross-entropy loss and turns the linear score into a probability
// with the sigmoid (Recipe 24).

#Playground("Classify with Logistic Regression") {
    // Hours studied → passed the exam (0 = failed, 1 = passed).
    // A clean threshold sits somewhere around five hours.
    let hours: [[Double]] = [
        [1.0], [2.0], [3.0], [4.0],
        [6.0], [7.0], [8.0], [9.0]
    ]
    let passed = [0, 0, 0, 0, 1, 1, 1, 1]

    // Fit learns the coefficients by gradient descent. Throws if the
    // descent diverges, so the call is marked `try`.
    let model = try LogisticRegression.fit(features: hours, labels: passed)
    print(model)

    // Predict a class label (0 or 1) for new students.
    let predictions = model.predict([[2.5], [7.5]])
    print("predictions:", predictions)  // [0, 1]

    // Inspect the learned coefficients and the equation for log-odds.
    print("coefficients:", model.coefficients)
    print(model.equation(variables: ["hours"]))

    // The scalar predict overload handles a single-feature model
    // without the nested-array ceremony.
    let oneStudent = model.predict(7.5)
    print("single prediction:", oneStudent)  // 1
}
