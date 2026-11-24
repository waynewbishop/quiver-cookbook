// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Embed each paragraph once. A query can match a paragraph by meaning.
#Playground("Retrieve a Passage for a Question") {
    struct WordEmbedder: Embedder {
        let vectors: [String: [Double]] = [
            "rise": [1.0, 0.1, 0.1],
            "knead": [0.1, 1.0, 0.1],
            "oven": [0.1, 0.1, 1.0],
            "temperature": [0.1, 0.2, 1.0]
        ]

        func embed(_ text: String) -> [Double]? {
            text.tokenize().embed(using: vectors).meanVector()
        }
    }

    struct ParagraphChunker: Chunker {
        func chunk(_ text: String) -> [Chunk] {
            text.components(separatedBy: "\n\n").asChunks()
        }
    }

    let document = """
    Let the dough rise.

    Knead until smooth.

    Bake in a hot oven.
    """

    var index = EmbeddingIndex<Chunk>(embedder: WordEmbedder())
    for chunk in document.chunked(using: ParagraphChunker()) {
        index.add(chunk.text, label: chunk)
    }

    // In this toy vocabulary, "temperature" points close to "oven".
    let result = index.retrieve("What temperature should I use?", k: 2)
    for hit in result.hits {
        print("#\(hit.rank): \(hit.label.text)")
    }
}
