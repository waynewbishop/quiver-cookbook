// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Playgrounds
import Quiver

// Keep values together by naming each column in a Panel.

#Playground("Organize Data with Panel") {
    // Create a Panel with named columns
    let data = Panel([
        ("age",     [25.0, 45.0, 35.0, 52.0, 23.0, 41.0, 33.0, 28.0]),
        ("income",  [35000.0, 72000.0, 55000.0, 88000.0, 28000.0, 65000.0, 48000.0, 38000.0]),
        ("score",   [620.0, 750.0, 680.0, 790.0, 590.0, 720.0, 660.0, 640.0])
    ])

    print(data.head(n: 5))
    let report = data.summary()
    print(report)
    if let incomeStats = report.columns["income"] {
        print("Income mean: \(incomeStats.mean)")
        print("Income standard deviation:  \(incomeStats.std)")
    }

    // Filter: keep only rows where score > 650
    let highScore = data["score"].isGreaterThan(650.0)
    let qualified = data.filtered(where: highScore)
    print("Qualified rows: \(qualified.rowCount)")

    // A Panel is a sequence of rows. Read each value by column name.
    for row in qualified {
        print("Qualified age \(row["age"]), score \(row["score"])")
    }

    // Split for ML: 80% train, 20% test — columns stay aligned
    let (train, test) = data.trainTestSplit(testRatio: 0.2, seed: 42)

    print("Training: \(train.shape)")
    print("Test: \(test.shape)")

    let features = train.toMatrix(columns: ["age", "income"])
    print("Feature matrix: \(features.shape)")
}
