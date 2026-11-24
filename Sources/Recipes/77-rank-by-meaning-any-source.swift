// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// An Embedder turns text into a vector. Here it averages known words.

#Playground("Rank by Meaning, Any Source") {
    let embeddings: [String: [Double]] = [
        "running":  [0.8, 0.7, 0.9, 0.2],
        "jogging":  [0.8, 0.7, 0.8, 0.2],
        "sprint":   [0.9, 0.6, 0.8, 0.1],
        "walking":  [0.5, 0.6, 0.4, 0.3],
        "cooking":  [0.1, 0.2, 0.1, 0.9],
        "baking":   [0.1, 0.3, 0.1, 0.8],
        "recipe":   [0.2, 0.2, 0.1, 0.9],
        "slow":     [0.3, 0.4, 0.2, 0.3],
    ]

    struct TableEmbedder: Embedder {
        let table: [String: [Double]]
        func embed(_ text: String) -> [Double]? {
            text.tokenize().embed(using: table).meanVector()
        }
    }

    let embedder = TableEmbedder(table: embeddings)

    let catalog = ["jogging sprint", "slow walking", "baking recipe"]
    let embedded = catalog.embedded(using: embedder)

    if let query = embedder.embed("running") {
        let hits = embedded.mostSimilar(to: query, k: 3)
        for hit in hits {
            print("#\(hit.rank) \(hit.text): \(String(format: "%.4f", hit.score))")
        }
    }
}
