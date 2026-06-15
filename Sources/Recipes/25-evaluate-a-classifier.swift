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

    // The confusion matrix captures all four outcomes in one struct
    let cm = predicted.confusionMatrix(actual: actual)

    // print() gives a clean one-line summary
    print(cm)  // TP: 4  FP: 1  TN: 4  FN: 1  (accuracy: 80.0%)

    // classificationReport() returns a typed ClassificationReport —
    // per-class precision, recall, F1, and support in one structured
    // value. Print it for the formatted table, or access individual
    // metrics programmatically.
    let report = predicted.classificationReport(actual: actual)
    print(report)
    print("Accuracy: \(String(format: "%.3f", report.accuracy))")
    if let macroF1 = report.macroAverage.f1Score {
        print("Macro F1: \(String(format: "%.3f", macroF1))")
    }
}
