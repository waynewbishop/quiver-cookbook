import Playgrounds
import Quiver

// Rank by Meaning, Any Source
// Search by Meaning (Recipe 21) hand-rolls the pipeline: tokenize,
// look up, average, then rank. The Embedder protocol names that
// conversion as a single contract — text in, vector out — so the
// ranking code stops caring where the vectors come from. Conform once,
// and embedded(using:) plus mostSimilar(to:k:) handle the rest. Swap a
// word-vector table for an on-device model and the ranking is untouched.

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

    // An Embedder is any type that turns a string into a vector. This
    // one averages word vectors; a sentence model would conform the
    // same way, and nothing downstream would change.
    struct TableEmbedder: Embedder {
        let table: [String: [Double]]
        func embed(_ text: String) -> [Double]? {
            text.tokenize().embed(using: table).meanVector()
        }
    }

    let embedder = TableEmbedder(table: embeddings)

    // embedded(using:) returns one (text, vector) pair per entry it can
    // embed, keeping each vector beside the text that produced it.
    let catalog = ["jogging sprint", "slow walking", "baking recipe"]
    let embedded = catalog.embedded(using: embedder)

    // mostSimilar ranks the pairs against a query in one call —
    // scoring, sorting, and labelling, all together.
    if let query = embedder.embed("running") {
        let hits = embedded.mostSimilar(to: query, k: 3)
        for hit in hits {
            print("#\(hit.rank) \(hit.text): \(String(format: "%.4f", hit.score))")
        }
    }
}
