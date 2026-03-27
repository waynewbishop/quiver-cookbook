import Playgrounds
import Quiver
import Foundation

// Save and Load a Trained Model
// Every Quiver model conforms to Codable, so a trained model can be
// encoded to JSON and decoded back with identical predictions. This
// means we train once and reuse across app launches, devices, or
// platforms — no retraining needed. The same pattern works for
// LinearRegression, GaussianNaiveBayes, KMeans, KNearestNeighbors,
// and FeatureScaler.

#Playground("Save and Load a Trained Model") {

    // Train the model
    let features: [[Double]] = [[1.0], [2.0], [3.0], [4.0], [5.0]]
    let targets = [2.1, 3.9, 6.1, 8.0, 9.8]
    let model = try LinearRegression.fit(features: features, targets: targets)

    // Convert the model to JSON bytes held in memory
    let data = try JSONEncoder().encode(model)

    // Convert the JSON bytes back into a model
    let restored = try JSONDecoder().decode(LinearRegression.self, from: data)

    print(model == restored)  // true
    print(restored.predict([[6.0]]))
}
