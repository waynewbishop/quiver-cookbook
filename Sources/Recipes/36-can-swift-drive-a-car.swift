import Playgrounds
import Quiver

// Can Swift Drive a Car?
// A fun, theoretical model that demonstrates how classification
// works on sensor data. This is NOT a self-driving car — it's a
// simplified simulation showing how K-Nearest Neighbors makes
// decisions based on the closest matching scenarios in its training
// data. Real autonomous vehicles use neural networks processing
// camera feeds, lidar, and radar. We use 3 columns and 12 rows.
// But the underlying question is the same: given what the sensors
// see right now, what should the car do next?

#Playground("Can Swift Drive a Car?") {

    // Simulated sensor readings from a car's instruments
    // Each row: [speed in mph, distance to obstacle in meters, lane offset in degrees]
    let telemetry: [[Double]] = [
        [60, 200, 0], [65, 180, 1], [55, 150, 0],   // open road — safe to accelerate
        [50, 50, 0],  [45, 30, 2],  [55, 40, 1],     // obstacle approaching — brake
        [40, 100, 15],[35, 80, 20], [45, 90, 18],     // drifting out of lane — steer back
        [50, 120, 0], [55, 140, 1], [60, 160, 0]      // steady traffic — maintain speed
    ]

    // Labels: what a human driver did in each scenario
    // In practice, these come from logged driving data or expert annotation
    // 0 = accelerate, 1 = maintain, 2 = brake, 3 = steer
    let actions = [0, 0, 0, 2, 2, 2, 3, 3, 3, 1, 1, 1]

    // Scale features so speed (0-65 mph), distance (0-200 m), and
    // lane offset (0-20°) contribute equally to distance calculations
    let scaler = FeatureScaler.fit(features: telemetry)
    let scaled = scaler.transform(telemetry)

    // Train on the driving scenarios — K-Nearest Neighbors classifies
    // each new reading by finding the 3 most similar situations it has
    // seen and voting on what the car did in those cases
    let model = KNearestNeighbors.fit(features: scaled, labels: actions, k: 3)
    print(model)

    // Simulate driving toward an obstacle at 55 mph
    // Watch the model transition from accelerate → maintain → brake
    // as the obstacle gets closer — no if-else rules, no hardcoded
    // thresholds, just the nearest training examples voting
    let labels = ["Accelerate", "Maintain", "Brake", "Steer"]

    for distance in stride(from: 200.0, to: 5.0, by: -25.0) {
        let reading = scaler.transform([[55.0, distance, 0.0]])
        let decision = model.predict(reading)[0]
        print("Distance: \(Int(distance))m → \(labels[decision])")
    }
}
