// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

#Playground("Find the Nearest Word") {
    let king = [0.9, 0.2, 0.8, 0.7]
    let man = [0.8, 0.1, 0.2, 0.6]
    let woman = [0.2, 0.8, 0.2, 0.6]

    let embeddings = [
        "king": king,
        "man": man,
        "woman": woman,
        "queen": [0.3, 0.9, 0.8, 0.7],
        "prince": [0.85, 0.25, 0.75, 0.65],
        "apple": [0.1, 0.1, 0.1, 0.1]
    ]

    // Look for the closest word to king − man + woman.
    let target = king.subtract(man).add(woman)
    let vocabulary = embeddings.sorted { $0.key < $1.key }
    let words = vocabulary.map { $0.key }
    let vectors = vocabulary.map { $0.value }
    let scores = vectors.cosineSimilarities(to: target)
    for result in scores.topIndices(k: 3, labels: words) {
        print("#\(result.rank) \(result.label): \(String(format: "%.4f", result.score))")
    }
}
