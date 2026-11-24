// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Playgrounds
import Quiver

// PCA projects columns onto axes ordered by explained variance.

#Playground("Compress a Dataset with PCA") {
    // Columns: floor area, bedrooms, lot size, age.
    let features: [[Double]] = [
        [1100, 2, 4.0, 15],
        [1400, 3, 5.5, 10],
        [1550, 3, 6.0, 7],
        [1700, 4, 6.5, 8],
        [1875, 4, 7.0, 3],
        [2350, 4, 9.0, 2],
        [2450, 5, 9.5, 1],
        [1200, 2, 4.5, 12]
    ]

    // Standardize the columns so their original units do not dominate PCA.
    let scaler = StandardScaler.fit(features: features)
    let standardized = scaler.transform(features)
    let pca = PCA.fit(features: standardized, componentCount: 2)

    print("Variance explained: \(pca.explainedVarianceRatios)")

    let reduced = pca.transform(standardized)
    print("Original shape: \(features.count) × \(features[0].count)")
    print("Reduced shape:  \(reduced.count) × \(reduced[0].count)")

    // Reconstruct one row and undo standardization to restore its units.
    let approximation = pca.inverseTransform([reduced[0]])[0]
    let restored = approximation.multiply(scaler.stds).add(scaler.means)
    print("Original row 0:  \(features[0])")
    print("Restored row 0:  \(restored)")
}
