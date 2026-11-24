// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// A relevance gate checks the top score against an absolute floor
// or its distance above the mean in standard deviations.
#Playground("Decide When Retrieval Is Good Enough") {
    struct WordEmbedder: Embedder {
        let vectors: [String: [Double]] = [
            "rise": [1.0, 0.1, 0.1, 0.0],
            "knead": [0.1, 1.0, 0.1, 0.0],
            "oven": [0.1, 0.1, 1.0, 0.0],
            "temperature": [0.1, 0.2, 1.0, 0.0],
            "battery": [0.1, 0.0, 0.0, 1.0]
        ]

        func embed(_ text: String) -> [Double]? {
            text.tokenize().embed(using: vectors).meanVector()
        }
    }

    var index = EmbeddingIndex<String>(embedder: WordEmbedder())
    for passage in ["Let the dough rise.", "Knead until smooth.", "Bake in a hot oven."] {
        index.add(passage, label: passage)
    }

    // With three passages, the score floor decides these examples.
    let questions = ["What temperature should I use?", "How do I charge a battery?"]
    for question in questions {
        let result = index.retrieve(question, k: 1)
        let score = String(format: "%.2f", result.topScore)
        let isRelevant = result.isAboveGate(floor: 0.30, outlierZ: 3.0)
        print("\(question) Top score: \(score)")
        print(isRelevant ? "Keep the passage." : "The document may not cover this question.")
    }
}
