import Playgrounds
import Quiver

// Classify with Naive Bayes
// Gaussian Naive Bayes learns the mean and variance of each feature
// for each class. It predicts by asking: "which class makes this
// data point most probable?" Fast, simple, and surprisingly effective.

#Playground("Classify with Naive Bayes") {

    // Weather data: [temperature °F, humidity %]
    // Class 0 = no rain, Class 1 = rain
    let features: [[Double]] = [
        [85.0, 30.0], [90.0, 25.0], [78.0, 40.0], [82.0, 35.0],  // no rain
        [65.0, 85.0], [60.0, 90.0], [68.0, 80.0], [62.0, 88.0]   // rain
    ]
    let labels = [0, 0, 0, 0, 1, 1, 1, 1]

    // Fit: the model computes mean and variance per feature per class
    // No iterative training — one pass through the data
    let model = GaussianNaiveBayes.fit(features: features, labels: labels)

    // Predict: will it rain given these conditions?
    let forecast: [[Double]] = [[80.0, 38.0], [63.0, 82.0]]
    let predictions = model.predict(forecast)  // [0, 1] — no rain, rain

    // Evaluate: how accurate is the model on training data?
    let trainPredictions = model.predict(features)
    let accuracy = trainPredictions.accuracy(actual: labels)

    print("Predictions: \(predictions)")             // [0, 1]
    print("Accuracy: \(String(format: "%.1f", accuracy * 100))%")
}
