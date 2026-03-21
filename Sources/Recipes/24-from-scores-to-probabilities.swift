import Playgrounds
import Quiver

// From Scores to Probabilities
// Raw model outputs are just numbers — they could be anything.
// Activation functions convert them into values we can interpret.
// Sigmoid squishes one score into a 0-1 probability.
// SoftMax distributes a set of scores into probabilities that sum to 1.

#Playground("From Scores to Probabilities") {

    // --- Sigmoid: binary decisions ---
    // "Is this email spam?" — one score, one probability
    let spamScores = [-2.0, -0.5, 0.0, 1.0, 3.5]

    // Sigmoid maps any number to the range (0, 1)
    // Negative → near 0 (unlikely), Positive → near 1 (likely), Zero → exactly 0.5
    let probabilities = spamScores.sigmoid()
    // [0.12, 0.38, 0.50, 0.73, 0.97]

    print("Spam scores:       \(spamScores)")
    print("Probabilities:     \(probabilities.map { String(format: "%.2f", $0) })")

    // --- SoftMax: choosing among categories ---
    // "Which animal is in this photo?" — one score per category
    let catScore  = 2.0   // model thinks "cat" is likely
    let dogScore  = 1.0   // "dog" is possible
    let birdScore = 0.1   // "bird" is unlikely

    // SoftMax converts scores into a probability distribution
    // All outputs are positive and sum to exactly 1.0
    let distribution = [catScore, dogScore, birdScore].softMax()

    let labels = ["cat", "dog", "bird"]
    for (label, prob) in zip(labels, distribution) {
        print("\(label): \(String(format: "%.1f", prob * 100))%")
    }

    // Verify: probabilities sum to 1.0
    let total = distribution.reduce(0, +)
    print("Sum: \(String(format: "%.1f", total))")  // 1.0
}
