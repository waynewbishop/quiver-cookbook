import Playgrounds
import Quiver

// King − Man + Woman = Queen
// Word embeddings encode meaning as geometry. Arithmetic on
// vectors captures semantic relationships — the most famous
// example in natural language processing.

#Playground("King − Man + Woman = Queen") {

    // Simplified 4D word embeddings (real ones have 50-300 dimensions)
    let king  = [0.9, 0.2, 0.8, 0.7]   // Male royalty
    let man   = [0.8, 0.1, 0.2, 0.6]   // Male concept
    let woman = [0.2, 0.8, 0.2, 0.6]   // Female concept
    let queen = [0.3, 0.9, 0.8, 0.7]   // Female royalty

    // Vector arithmetic: king - man + woman
    // Subtracting "man" removes the male component.
    // Adding "woman" replaces it with the female component.
    // The result should land near "queen."
    let result = king.subtract(man).add(woman)  // [0.3, 0.9, 0.8, 0.7]

    // How close is our result to the actual "queen" vector?
    // Cosine similarity of ~1.0 means nearly identical direction
    let similarity = result.cosineOfAngle(with: queen)  // ~1.0

    // Compare: the result is far from "king" — it shifted meaning
    let vsKing = result.cosineOfAngle(with: king)  // ~0.68

    print("Result:      \(result)")
    print("vs Queen:    \(String(format: "%.4f", similarity))")   // ~1.0
    print("vs King:     \(String(format: "%.4f", vsKing))")       // ~0.68
}
