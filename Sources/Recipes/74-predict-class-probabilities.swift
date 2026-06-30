import Playgrounds
import Quiver

// Predict Class Probabilities
// A class label answers "which side?" — but often we want the
// confidence behind that answer. Logistic regression (Recipe 73)
// produces a calibrated probability between 0 and 1 for the positive
// class, so we can decide how sure the model must be before we act.
// predictProbabilities returns P(class = 1) per sample.

#Playground("Predict Class Probabilities") {

    // Hours studied → passed the exam (0 = failed, 1 = passed).
    let hours: [[Double]] = [
        [1.0], [2.0], [3.0], [4.0],
        [6.0], [7.0], [8.0], [9.0]
    ]
    let passed = [0, 0, 0, 0, 1, 1, 1, 1]

    let model = try LogisticRegression.fit(features: hours, labels: passed)

    // One probability per sample: the model's confidence that the
    // student passes. The 5-hour student is the least decisive of the
    // three — its probability sits closest to the undecided midpoint.
    let probabilities = model.predictProbabilities([[2.0], [5.0], [8.0]])
    for (h, p) in zip([2.0, 5.0, 8.0], probabilities) {
        print("\(h)h → P(pass) = \(String(format: "%.3f", p))")
    }
    // 2.0h → 0.346, 5.0h → 0.654, 8.0h → 0.871

    // The default decision thresholds at 0.5. Raising the bar — only
    // act when the model is at least 80% sure — is one line on top of
    // the probabilities, no retraining required.
    let confident = probabilities.map { $0 >= 0.8 ? 1 : 0 }
    print("confident calls:", confident)
}
