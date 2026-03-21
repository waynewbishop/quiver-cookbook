import Playgrounds
import Quiver

// Evaluate a Classifier
// Accuracy alone can be misleading — if 95% of emails are not spam,
// a model that always predicts "not spam" gets 95% accuracy while
// catching zero spam. Precision, recall, and F1 reveal the full picture.

#Playground("Evaluate a Classifier") {

    // A model predicted these classes (0 = no rain, 1 = rain)
    let predicted = [0, 1, 1, 0, 1, 0, 1, 1, 0, 0]
    let actual    = [0, 1, 0, 0, 1, 1, 1, 1, 0, 0]

    // Accuracy: what fraction of predictions were correct?
    let acc = predicted.accuracy(actual: actual)  // 0.8 (80%)

    // Precision: of the times we predicted rain, how often was it right?
    // High precision = few false alarms
    let prec = predicted.precision(actual: actual)  // fraction of true positives among predicted positives

    // Recall: of the actual rainy days, how many did we catch?
    // High recall = few missed cases
    let rec = predicted.recall(actual: actual)  // fraction of true positives among actual positives

    // F1: harmonic mean of precision and recall — balances both
    let f1 = predicted.f1Score(actual: actual)

    print("Accuracy:  \(String(format: "%.1f", acc * 100))%")
    print("Precision: \(prec.map { String(format: "%.2f", $0) } ?? "N/A")")
    print("Recall:    \(rec.map { String(format: "%.2f", $0) } ?? "N/A")")
    print("F1 Score:  \(f1.map { String(format: "%.2f", $0) } ?? "N/A")")
}
