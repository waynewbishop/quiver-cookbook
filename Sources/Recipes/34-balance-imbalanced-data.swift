import Playgrounds
import Quiver

// Balance Imbalanced Data
// When one class vastly outnumbers another, models tend to
// predict the larger class and ignore the smaller one. The
// oversample function generates synthetic points for
// smaller classes by interpolating between existing
// samples — using the same vector arithmetic from Recipes 1-3.
// It auto-detects which classes need more samples.

#Playground("Balance Imbalanced Data") {

    // Imbalanced dataset: 8 negative, 2 positive
    let features: [[Double]] = [
        [1.0, 2.0], [1.5, 1.8], [2.0, 2.5], [1.2, 2.1],
        [1.8, 1.5], [2.2, 2.8], [1.4, 1.9], [1.7, 2.3],
        [7.0, 8.0], [7.5, 8.5]
    ]
    let labels = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1]

    // Check: how imbalanced is this data?
    print(labels.classDistribution())  // [0: 8, 1: 2]
    if let ratio = labels.imbalanceRatio() {
        print("Imbalance ratio: \(ratio)")  // 4.0 — the larger class is 4x bigger
    }

    // Balance — oversample auto-detects the smaller class
    let (balanced, balancedLabels) = features.oversample(labels: labels)

    // Original: 8 vs 2. Balanced: 8 vs 8.
    // Six synthetic points were generated between the two existing
    // class-1 samples, filling in the gap so the model sees enough
    // examples of both classes during training.
    print("Before: \(features.count) samples → After: \(balanced.count) samples")

    // Now split, train, and evaluate on balanced data
    let split = balanced.stratifiedSplit(
        labels: balancedLabels, testRatio: 0.2, seed: 42
    )

    let model = KNearestNeighbors.fit(
        features: split.trainFeatures,
        labels: split.trainLabels,
        k: 3
    )

    let predictions = model.predict(split.testFeatures)
    print(predictions.classificationReport(actual: split.testLabels))
}
