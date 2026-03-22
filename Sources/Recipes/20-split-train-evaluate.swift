import Playgrounds
import Quiver

// Split, Train, Evaluate
// This recipe connects the full arc: arrays are split into train
// and test sets, a model learns from the training data using the
// vector math from earlier recipes (mean, variance, distance),
// and evaluation metrics measure how well the model generalizes
// to data it has never seen.

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
    // classificationReport() computes accuracy, precision, recall,
    // and F1 in one call and formats them as a readable summary
    print("Test predictions: \(predictions)")
    print(predictions.classificationReport(actual: testY))
}
