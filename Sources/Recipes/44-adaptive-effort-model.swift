import Playgrounds
import Quiver

// Adaptive Effort Model — How a Running Model Learns You
// Start with anchor points that define the corners of effort space.
// As real workout data accumulates, the centroids migrate toward
// where this specific runner actually operates. The model personalizes.

#Playground("Adaptive Effort Model") {

    // Anchors — canonical effort types for trail running
    // [HR, pace (min/km), cadence, grade (%), power (W), vert osc (cm)]
    let anchors: [[Double]] = [
        [135, 6.5, 165,   0.0, 195,  9.5],   // Easy
        [170, 12.0, 110,  15.0, 280,  4.5],   // Power Hike
        [168, 4.5, 185, -12.0, 160, 11.5]     // Downhill
    ]

    // Phase 1 — anchors alone define the starting centroids
    let phase1 = KMeans.fit(data: anchors, k: 3, seed: 42)
    print("Phase 1 — starting centroids (anchors only):")
    phase1.centroids.forEach { print("  \($0)") }

    // Three workouts on Green Mountain, Boulder — unlabeled
    let workouts: [[Double]] = [
        // This runner's easy is a bit faster and lower HR than the anchor
        [128, 6.2, 168,   0.5, 190,  9.8],
        [130, 6.0, 170,   1.0, 185, 10.0],
        [132, 6.3, 166,  -0.5, 192,  9.6],

        // This runner's power hikes hit steeper grades
        [174, 13.5, 105,  20.0, 295,  3.8],
        [168, 12.8, 108,  17.0, 275,  4.2],

        // This runner's descents are steeper and faster
        [165, 4.0, 190, -15.0, 148, 12.2],
        [170, 4.2, 188, -14.0, 152, 12.0]
    ]

    // Phase 2 — combine anchors + workout data, scale, re-cluster
    let combined = anchors + workouts
    let scaler = FeatureScaler.fit(features: combined)
    let scaled = scaler.transform(combined)
    let phase2 = KMeans.fit(data: scaled, k: 3, seed: 42)

    print("\nPhase 2 — refined centroids (after 3 workouts):")
    phase2.centroids.forEach { print("  \($0)") }

    // Phase 3 — classify new efforts using the personalized model
    let zones = ["Easy", "Power Hike", "Downhill"]
    let model = KNearestNeighbors.fit(
        features: scaled, labels: phase2.labels, k: 3,
        metric: .euclidean, weight: .distance)

    // Same heart rate. The refined model still tells them apart.
    let hiking  = scaler.transform([[170, 12.0, 112, 16.0, 285, 4.3]])
    let descent = scaler.transform([[170, 4.3, 187, -13.0, 155, 11.9]])

    print("\nBoth show HR: 170 BPM")
    print("Power hiking uphill:  \(zones[model.predict(hiking)[0]])")
    print("Running downhill:     \(zones[model.predict(descent)[0]])")
}
