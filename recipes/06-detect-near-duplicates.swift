import Playgrounds
import Quiver

// Detect Near-Duplicates
// findDuplicates compares every pair of vectors and returns
// those with cosine similarity above your threshold.
// Useful for deduplication in document sets, product catalogs, or embeddings.

#Playground("Detect Near-Duplicates") {

    // Five document vectors — two are suspiciously similar
    let documents: [[Double]] = [
        [0.8, 0.7, 0.9],   // Doc 0
        [0.2, 0.9, 0.1],   // Doc 1 — unique topic
        [0.81, 0.71, 0.89], // Doc 2 — nearly identical to Doc 0
        [0.1, 0.3, 0.8],   // Doc 3 — different
        [0.19, 0.88, 0.12] // Doc 4 — nearly identical to Doc 1
    ]

    // Find all pairs with cosine similarity above 0.99
    let duplicates = documents.findDuplicates(threshold: 0.99)

    // Each result is (index1, index2, similarity score)
    for pair in duplicates {
        print("Docs \(pair.0) and \(pair.1): similarity = \(String(format: "%.4f", pair.2))")
    }
    // Docs 0 and 2 are near-duplicates
    // Docs 1 and 4 are near-duplicates
}
