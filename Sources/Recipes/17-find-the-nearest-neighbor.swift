import Playgrounds
import Quiver

// Find the Nearest Neighbor
// KNN classifies a point using the same distance(to:) from Recipe 1 —
// the Pythagorean theorem extended to any number of dimensions.
// It measures distance to every training point, finds the K closest,
// and takes a majority vote. No parameters are learned — the vector
// math IS the algorithm.

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

    // Classify: computes distance(to:) for every training point
    // (same Pythagorean theorem from Recipe 1), sorts by nearest,
    // and the 3 closest vote on the class.
    // classify() groups the results by predicted label —
    // each Classification has a label and the points assigned to it
    let newPoints: [[Double]] = [[2.0, 3.0], [5.0, 7.0], [3.5, 5.0]]
    let results = model.classify(newPoints)

    for group in results {
        print("Class \(group.label): \(group.count) points")
        for point in group {
            print("  \(point)")
        }
    }

    // predict() returns raw labels for evaluation pipelines
    let predictions = model.predict(newPoints)
    print("Raw labels: \(predictions)")  // [0, 1, 1]
}
