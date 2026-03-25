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

    // classificationReport() shows per-class metrics with averages
    print(predicted.classificationReport(actual: actual))
}
