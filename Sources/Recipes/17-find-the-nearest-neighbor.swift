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

    // Predict: computes distance(to:) for every training point
    // (same Pythagorean theorem from Recipe 1), sorts by nearest,
    // and the 3 closest vote on the class
    let newPoints: [[Double]] = [[2.0, 3.0], [5.0, 7.0], [3.5, 5.0]]
    let predictions = model.predict(newPoints)

    // [2, 3] is near cluster A → class 0
    // [5, 7] is near cluster B → class 1
    // [3.5, 5] is in between → depends on which neighbors are closest
    print("Predictions: \(predictions)")
    
    //TODO: do the predictions conform to sequence, similar to k-means?
    //I would like to see which class of content which prediction maps
    //back to from an educational standpoint. This would be similar to the
    //clusters with k-means.
    
    /*
     for prediction in predictions {
        //now extract prediction information..
     }
     */
        
}
