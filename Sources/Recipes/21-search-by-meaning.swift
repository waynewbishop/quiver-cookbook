// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

#Playground("Search by Meaning") {
    let embeddings: [String: [Double]] = [
        "running": [0.8, 0.7, 0.9, 0.2],
        "jogging": [0.8, 0.7, 0.8, 0.2],
        "sprint": [0.9, 0.6, 0.8, 0.1],
        "walking": [0.5, 0.6, 0.4, 0.3],
        "baking": [0.1, 0.3, 0.1, 0.8],
        "recipe": [0.2, 0.2, 0.1, 0.9],
        "fast": [0.7, 0.5, 0.6, 0.1],
        "slow": [0.3, 0.4, 0.2, 0.3]
    ]

    // Average the vectors for the known words in each phrase.
    let queryWords = "fast running".tokenize()
    guard let query = queryWords.embed(using: embeddings).meanVector() else { return }

    let catalog = ["jogging sprint", "slow walking", "baking recipe"]
    let vectors = catalog.compactMap { text in
        text.tokenize().embed(using: embeddings).meanVector()
    }
    // The fixed catalog has known words in every phrase, so labels stay aligned.
    guard vectors.count == catalog.count else { return }
    let scores = vectors.cosineSimilarities(to: query)

    for result in scores.topIndices(k: 3, labels: catalog) {
        print("#\(result.rank) \(result.label): \(String(format: "%.4f", result.score))")
    }
}
