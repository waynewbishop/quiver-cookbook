import Playgrounds
import Quiver

// Split, Train, Evaluate
// The complete mini-pipeline: hold out test data, train a model,
// then evaluate on data the model has never seen.
// This prevents overfitting — memorizing answers vs learning patterns.

#Playground("Split, Train, Evaluate") {

    // Weather data: [temperature °F, humidity %]
    // Class 0 = no rain, Class 1 = rain
    let features: [[Double]] = [
        [85.0, 30.0], [90.0, 25.0], [78.0, 40.0], [82.0, 35.0], [88.0, 28.0],
        [65.0, 85.0], [60.0, 90.0], [68.0, 80.0], [62.0, 88.0], [64.0, 82.0]
    ]
    let labels = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1]

    // Step 1: Split — 80% train, 20% test
    // The seed ensures the same split every time (reproducible)
    let (trainX, testX) = features.trainTestSplit(testRatio: 0.2, seed: 42)
    let (trainY, testY) = labels.trainTestSplit(testRatio: 0.2, seed: 42)

    // Step 2: Train on the training set only
    let model = GaussianNaiveBayes.fit(features: trainX, labels: trainY)

    // Step 3: Predict on data the model has never seen
    let predictions = model.predict(testX)

    // Step 4: Evaluate — how well did we do on unseen data?
    let acc = predictions.accuracy(actual: testY)
    let prec = predictions.precision(actual: testY)
    let rec = predictions.recall(actual: testY)
    let f1 = predictions.f1Score(actual: testY)

    print("Test predictions: \(predictions)")
    print("Accuracy:  \(String(format: "%.1f", acc * 100))%")
    print("Precision: \(prec.map { String(format: "%.2f", $0) } ?? "N/A")")
    print("Recall:    \(rec.map { String(format: "%.2f", $0) } ?? "N/A")")
    print("F1 Score:  \(f1.map { String(format: "%.2f", $0) } ?? "N/A")")
}
