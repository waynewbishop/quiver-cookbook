import Playgrounds
import Quiver

// Find the Nearest Neighbor
// K-Nearest Neighbors classifies a point by finding the K closest
// training examples and taking a majority vote. No parameters are
// learned during training — the data IS the model.

#Playground("Find the Nearest Neighbor") {

    // Two clear clusters in 2D space
    let features: [[Double]] = [
        [1.0, 2.0], [1.5, 1.8], [1.2, 2.1],   // cluster A (class 0)
        [5.0, 8.0], [6.0, 9.0], [5.5, 7.5]    // cluster B (class 1)
    ]
    let labels = [0, 0, 0, 1, 1, 1]

    // Fit: stores the training data — nothing is computed yet
    let model = KNearestNeighbors.fit(
        features: features, labels: labels,
        k: 3, metric: .euclidean, weight: .uniform
    )

    // Predict: measures distance to every training point,
    // finds the 3 closest, and votes on the class
    let newPoints: [[Double]] = [[2.0, 3.0], [5.0, 7.0], [3.5, 5.0]]
    let predictions = model.predict(newPoints)

    // [2, 3] is near cluster A → class 0
    // [5, 7] is near cluster B → class 1
    // [3.5, 5] is in between → depends on which neighbors are closest
    print("Predictions: \(predictions)")
}
