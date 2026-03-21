import Playgrounds
import Quiver

// Find the Most Similar Item
// Cosine similarity measures how closely two vectors point
// in the same direction, ignoring their length.
// Score: 1.0 = identical direction, 0.0 = unrelated, -1.0 = opposite.

#Playground("Find the Most Similar Item") {

    // A query vector (what the user likes)
    let query = [0.8, 0.7, 0.9]

    // A catalog of 5 items, each described by 3 features
    let catalog: [[Double]] = [
        [0.8, 0.6, 0.9],   // Item A — very similar to query
        [0.2, 0.3, 0.1],   // Item B — very different
        [0.7, 0.7, 0.8],   // Item C — quite similar
        [0.1, 0.9, 0.2],   // Item D — different profile
        [0.9, 0.8, 0.85]   // Item E — strong match
    ]

    // Score every item against the query in one call
    let scores = catalog.cosineSimilarities(to: query)
    // Each score is between -1.0 and 1.0

    // Get the top 3 matches, ranked by similarity
    let top3 = scores.topIndices(k: 3)

    // Print ranked results
    let labels = ["A", "B", "C", "D", "E"]
    for result in top3 {
        print("Item \(labels[result.index]): \(String(format: "%.4f", result.score))")
    }
    // Items C, A, E rank highest — they point in a similar direction to the query
}
