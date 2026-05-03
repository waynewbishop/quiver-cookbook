import Playgrounds
import Quiver
import Foundation

// Calibrated Class Probabilities
// `predict(_:)` returns one label per sample — the model's best
// guess. `predictProbabilities(_:)` returns the full probability
// distribution across classes for each sample. These calibrated
// probabilities power cost-sensitive decisions: when a false
// positive is more expensive than a false negative, we can demand
// higher confidence before predicting the positive class. This
// recipe shows that each row sums to 1.0 and tunes a custom
// decision threshold.

#Playground("Calibrated Class Probabilities") {

    // Two-class data: weather features → rain (1) or no rain (0)
    let features: [[Double]] = [
        [85, 30], [90, 25], [78, 40], [82, 35],
        [65, 85], [60, 90], [68, 80], [62, 88]
    ]
    let labels = [0, 0, 0, 0, 1, 1, 1, 1]
    let model = GaussianNaiveBayes.fit(features: features, labels: labels)

    // Probabilities for new samples — shape [samples × classes]
    let queries: [[Double]] = [[80, 40], [70, 70], [66, 82]]
    let probs = model.predictProbabilities(queries)

    // Each row sums to 1.0 — the full distribution over classes
    for i in 0..<probs.count {
        let row = probs[i]
        let pNoRain = String(format: "%.3f", row[0])
        let pRain   = String(format: "%.3f", row[1])
        let total   = String(format: "%.3f", row[0] + row[1])
        print("query \(i): P(no rain) = \(pNoRain), P(rain) = \(pRain), sum = \(total)")
    }

    // Cost-sensitive decision: predict rain only when P(rain) > 0.7
    let threshold = 0.7
    var decisions: [Int] = []
    for row in probs {
        if row[1] > threshold {
            decisions.append(1)
        } else {
            decisions.append(0)
        }
    }
    print("Decisions at P(rain) > \(threshold): \(decisions)")
}
