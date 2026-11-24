// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Playgrounds
import Quiver

// With an intercept, Fahrenheit duplicates information already in
// Celsius and the constant column: F = 1.8 × C + 32.

#Playground("Fix a Singular Regression Fit") {
    let temperatures: [[Double]] = [[0, 32], [10, 50], [20, 68], [30, 86], [40, 104]]
    let demand = [120.0, 135.0, 150.0, 170.0, 190.0]

    do {
        _ = try LinearRegression.fit(features: temperatures, targets: demand)
    } catch MatrixError.singular {
        print("Fahrenheit duplicates Celsius once the intercept is included.")

        let celsius = temperatures.map { $0[0] }
        let model = try LinearRegression.fit(features: celsius, targets: demand)
        print(model.equation(variables: ["celsius"], response: "demand"))
    }
}
