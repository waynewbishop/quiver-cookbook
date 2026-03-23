import Playgrounds
import Quiver

// Classify with Naive Bayes
// Gaussian Naive Bayes uses the same statistics from Recipe 7 —
// mean and variance — but computes them per class. For each new
// data point, it evaluates the Gaussian probability density function
// (built from exp() and the statistics) and picks the class with
// the highest probability. The math is familiar; the application is ML.

#Playground("Classify with Naive Bayes") {

    // Weather data: [temperature °F, humidity %]
    // Class 0 = no rain, Class 1 = rain
    let features: [[Double]] = [
        [85.0, 30.0], [90.0, 25.0], [78.0, 40.0], [82.0, 35.0],  // no rain
        [65.0, 85.0], [60.0, 90.0], [68.0, 80.0], [62.0, 88.0]   // rain
    ]
    let labels = [0, 0, 0, 0, 1, 1, 1, 1]

    // Fit: computes mean() and variance() per feature per class —
    // the same statistics from Recipe 7, applied per group
    let model = GaussianNaiveBayes.fit(features: features, labels: labels)

    // Classify: groups results by predicted label.
    // Each Classification has a label and the points assigned to it —
    // the same pattern as clusters in K-Means (Recipe 18)
    let forecast: [[Double]] = [[80.0, 38.0], [63.0, 82.0], [75.0, 45.0]]
    let results = model.classify(forecast)

    let classNames = ["No Rain", "Rain"]
    for group in results {
        print("\(classNames[group.label]): \(group.count) forecasts")
        for point in group {
            print("  temp: \(point[0])°F, humidity: \(point[1])%")
        }
    }

    // predict() still available for evaluation pipelines
    let trainPredictions = model.predict(features)
    let accuracy = trainPredictions.accuracy(actual: labels)
    print("Training accuracy: \(String(format: "%.1f", accuracy * 100))%")
}
