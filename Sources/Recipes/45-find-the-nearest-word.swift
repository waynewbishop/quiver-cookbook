import Playgrounds
import Quiver

// Find the Nearest Word
// Word embeddings live in a dictionary keyed by string. Given a
// query vector, ranking every entry by cosine similarity returns
// the words closest in meaning. This is the lookup that powers
// analogy queries, synonym finders, and recommendation by example.

#Playground("Find the Nearest Word") {

    // A small vocabulary of word vectors (real ones have 50-300 dimensions).
    // Recipe 21 covered searching across documents; this recipe searches
    // the embedding dictionary itself for words nearest a query.
    let king   = [0.9, 0.2, 0.8, 0.7]
    let queen  = [0.3, 0.9, 0.8, 0.7]
    let man    = [0.8, 0.1, 0.2, 0.6]
    let woman  = [0.2, 0.8, 0.2, 0.6]
    let prince = [0.85, 0.25, 0.75, 0.65]
    let apple  = [0.1, 0.1, 0.1, 0.1]

    let embeddings: [String: [Double]] = [
        "king":   king,
        "queen":  queen,
        "man":    man,
        "woman":  woman,
        "prince": prince,
        "apple":  apple
    ]

    // The classic analogy: king - man + woman should land near queen.
    // Recipe 05 stopped at the cosineOfAngle check; this recipe asks
    // a stronger question — of every word in the vocabulary, which
    // one is actually closest to the result?
    let target = king.subtract(man).add(woman)

    // Pull the dictionary into parallel word and vector arrays so the
    // vector array can be ranked all at once.
    var words: [String] = []
    var vectors: [[Double]] = []
    
    for (word, vector) in embeddings {
        words.append(word)
        vectors.append(vector)
    }

    // cosineSimilarities scores every vector against the target in one
    // call, returning a parallel array of similarity values in [-1, 1].
    let scores = vectors.cosineSimilarities(to: target)

    // topIndices returns the ranked top k by score — same primitive
    // used in Recipe 4 to find the most similar item in a catalog.
    let top3 = scores.topIndices(k: 3)

    // The top match is "queen" — the analogy lands where the math says
    // it should. "king" and "prince" follow because royalty vectors
    // cluster together regardless of gender.
    for result in top3 {
        let word = words[result.index]
        print("#\(result.rank) \(word): \(String(format: "%.4f", result.score))")
    }
}
