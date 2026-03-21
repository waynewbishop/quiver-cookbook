import Playgrounds
import Quiver

// Search by Meaning
// Semantic search finds results based on what words mean,
// not whether they match exactly. The pipeline: split text into
// words, look up each word's vector, average them into a single
// document vector, then rank by cosine similarity.

#Playground("Search by Meaning") {

    // A small vocabulary of word vectors (real ones have 50-300 dimensions)
    let embeddings: [String: [Double]] = [
        "running":  [0.8, 0.7, 0.9, 0.2],
        "jogging":  [0.8, 0.7, 0.8, 0.2],
        "sprint":   [0.9, 0.6, 0.8, 0.1],
        "walking":  [0.5, 0.6, 0.4, 0.3],
        "cooking":  [0.1, 0.2, 0.1, 0.9],
        "baking":   [0.1, 0.3, 0.1, 0.8],
        "recipe":   [0.2, 0.2, 0.1, 0.9],
        "fast":     [0.7, 0.5, 0.6, 0.1],
        "slow":     [0.3, 0.4, 0.2, 0.3],
    ]

    // Step 1: Tokenize — split text into lowercase words
    let query = "fast running"
    let queryWords = query.tokenize()  // ["fast", "running"]

    // Step 2: Look up vectors for each word
    let queryVectors = queryWords.compactMap { embeddings[$0] }

    // Step 3: Average into a single vector representing the whole phrase
    let queryVector = queryVectors.meanVector()!  // [0.75, 0.6, 0.75, 0.15]

    // A catalog of text descriptions to search
    let catalog = ["jogging sprint", "slow walking", "baking recipe", "cooking slow"]

    // Step 4: Embed each catalog entry the same way
    let catalogVectors = catalog.map { text -> [Double] in
        let words = text.tokenize()
        let vecs = words.compactMap { embeddings[$0] }
        return vecs.meanVector() ?? []
    }

    // Step 5: Rank by cosine similarity — direction, not magnitude
    let scores = catalogVectors.cosineSimilarities(to: queryVector)
    let results = scores.topIndices(k: 3, labels: catalog)

    // "jogging sprint" ranks highest — closest in meaning to "fast running"
    for r in results {
        print("\(r.label): \(String(format: "%.4f", r.score))")
    }
}
