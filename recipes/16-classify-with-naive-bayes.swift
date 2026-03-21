import Playgrounds
import Quiver

// Classify with Naive Bayes
// Gaussian Naive Bayes learns the mean and variance of each feature
// for each class. It predicts by asking: "which class makes this
// data point most probable?" Fast, simple, and surprisingly effective.

#Playground("Classify with Naive Bayes") {

    // Iris-style data: [sepal length, sepal width]
    // Class 0 = small flowers, Class 1 = large flowers
    let features: [[Double]] = [
        [5.1, 3.5], [4.9, 3.0], [4.7, 3.2], [5.0, 3.4],  // class 0
        [7.0, 3.2], [6.4, 3.2], [6.9, 3.1], [6.5, 2.8]   // class 1
    ]
    let labels = [0, 0, 0, 0, 1, 1, 1, 1]

    // Fit: the model computes mean and variance per feature per class
    // No iterative training — one pass through the data
    let model = GaussianNaiveBayes.fit(features: features, labels: labels)

    // Predict: which class does a new flower belong to?
    let newFlowers: [[Double]] = [[5.0, 3.3], [6.7, 3.0]]
    let predictions = model.predict(newFlowers)  // [0, 1]

    // Evaluate: how accurate is the model on training data?
    let trainPredictions = model.predict(features)
    let accuracy = trainPredictions.accuracy(actual: labels)

    print("Predictions: \(predictions)")             // [0, 1]
    print("Accuracy: \(String(format: "%.1f", accuracy * 100))%")
}
