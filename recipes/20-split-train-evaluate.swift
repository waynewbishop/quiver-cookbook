import Playgrounds
import Quiver

// Split, Train, Evaluate
// The complete mini-pipeline: hold out test data, train a model,
// then evaluate on data the model has never seen.
// This prevents overfitting — memorizing answers vs learning patterns.

#Playground("Split, Train, Evaluate") {

    // Feature data: [sepal length, sepal width]
    let features: [[Double]] = [
        [5.1, 3.5], [4.9, 3.0], [4.7, 3.2], [5.0, 3.4], [4.6, 3.1],
        [7.0, 3.2], [6.4, 3.2], [6.9, 3.1], [6.5, 2.8], [6.2, 3.4]
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
