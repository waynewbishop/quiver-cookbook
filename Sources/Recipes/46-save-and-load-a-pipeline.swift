import Playgrounds
import Quiver
import Foundation

// Save and Load a Pipeline
// A Pipeline bundles a fitted scaler with a trained model so they
// travel together as one Codable value. Saving the model alone is
// the most common ML mistake — predictions on new data come out
// wrong because the scaler is gone. Pipeline eliminates that risk
// by encoding the scaler and model into a single JSON blob. This
// recipe sits beside Recipe 35, which covers a bare model without
// a scaler.

#Playground("Save and Load a Pipeline") {

    // Train a K-Nearest Neighbors classifier with automatic scaling
    let features: [[Double]] = [[1, 2], [3, 4], [5, 8], [6, 9]]
    let labels = [0, 0, 1, 1]
    let pipeline = Pipeline.fit(features: features, labels: labels, k: 3)

    // Encode the scaler and model together as one JSON value
    let data = try JSONEncoder().encode(pipeline)

    // Decode back into a working Pipeline
    let restored = try JSONDecoder().decode(
        Pipeline<KNearestNeighbors>.self, from: data
    )

    // Predictions on raw (unscaled) features are identical
    let new: [[Double]] = [[2, 3], [5, 7]]
    print(pipeline.predict(new))   // [0, 1]
    print(restored.predict(new))   // [0, 1]
    print(pipeline == restored)    // true
}
