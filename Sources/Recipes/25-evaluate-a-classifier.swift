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

    // classificationReport() computes all four metrics in one call:
    // - Accuracy: what fraction of predictions were correct?
    // - Precision: of predicted positives, how many were right? (few false alarms)
    // - Recall: of actual positives, how many did we catch? (few missed cases)
    // - F1: harmonic mean of precision and recall — balances both
    print(predicted.classificationReport(actual: actual))
}
