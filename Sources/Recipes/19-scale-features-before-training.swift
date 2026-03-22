import Playgrounds
import Quiver

// Scale Features Before Training
// The distance(to:) operation from Recipe 1 treats all dimensions
// equally — but when features have different magnitudes, larger
// values dominate. A credit score (300-850) and an account balance
// (0-250,000) are six orders of magnitude apart. Without scaling,
// distance is effectively measured in dollars only. Scaling brings
// all features to the same range so each one contributes fairly.

#Playground("Scale Features Before Training") {

    // Raw features: [credit score, account balance]
    // Balance is ~300× larger than credit score — it will dominate distance
    let features: [[Double]] = [
        [720.0, 15000.0],
        [650.0, 78000.0],
        [580.0, 42000.0],
        [710.0, 8000.0],
        [690.0, 55000.0],
        [620.0, 91000.0]
    ]
    let labels = [1, 0, 0, 1, 1, 0]

    // Fit scaler on training data — learns min and max per feature
    let scaler = FeatureScaler.fit(features: features)

    // Transform: each feature scaled to 0.0-1.0 range
    let scaled = scaler.transform(features)
    print("Before: \(features[0])")   // [720.0, 15000.0]
    print("After:  \(scaled[0])")      // [1.0, ~0.08]

    // Now train KNN on scaled data — both features contribute equally
    let model = KNearestNeighbors.fit(
        features: scaled, labels: labels,
        k: 3, metric: .euclidean, weight: .uniform
    )

    // Scale new data with the SAME scaler (prevents data leakage)
    let newCustomer = scaler.transform([[700.0, 30000.0]])
    let prediction = model.predict(newCustomer)
    print("Prediction: \(prediction)")
}
