import Playgrounds
import Quiver

// True Effort Score — Trail Running in Boulder
// Power hiking uphill: slow pace, high heart rate.
// Running downhill: fast pace, moderate heart rate, quads destroyed.
// Both can show 170 BPM. Heart rate alone cannot tell them apart.
// Six signals can.

#Playground("True Effort Score") {

    // [HR, pace (min/km), cadence, grade (%), power (W), vert osc (cm)]
    // Simulated trail runner on Green Mountain, Boulder, CO (5,400 ft)
    let samples: [[Double]] = [
        // Easy — flat single track, recovery pace
        [135, 6.5, 165,   0.0, 195,  9.5],
        [130, 6.8, 162,   0.0, 185,  9.8],
        [138, 6.3, 167,   0.5, 200,  9.3],
        [132, 6.6, 164,   0.0, 190,  9.6],

        // Power hike — slow crawl uphill, HR through the roof
        [170, 12.0, 110,  15.0, 280,  4.5],
        [175, 13.0, 105,  18.0, 300,  4.0],
        [168, 11.5, 115,  14.0, 270,  5.0],
        [172, 12.5, 108,  16.0, 290,  4.2],

        // Downhill — fast turnover, HR still elevated, quads absorbing impact
        [168, 4.5, 185, -12.0, 160, 11.5],
        [165, 4.2, 188, -14.0, 150, 12.0],
        [170, 4.8, 182, -10.0, 170, 11.0],
        [166, 4.4, 186, -13.0, 155, 11.8]
    ]

    // 0 = easy, 1 = power hike, 2 = downhill
    let effort = [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2]

    // Scale so all six signals contribute equally
    let scaler = FeatureScaler.fit(features: samples)
    let scaled = scaler.transform(samples)
    let model = KNearestNeighbors.fit(
        features: scaled, labels: effort, k: 3,
        metric: .euclidean, weight: .distance)

    let zones = ["Easy", "Power Hike", "Downhill"]

    // Same heart rate. Totally different effort.
    let hiking  = scaler.transform([[170, 12.0, 112, 16.0, 285, 4.3]])
    let descent = scaler.transform([[170, 4.3, 187, -13.0, 155, 11.9]])

    print("Both show HR: 170 BPM")
    print("Power hiking uphill:  \(zones[model.predict(hiking)[0]])")
    print("Running downhill:     \(zones[model.predict(descent)[0]])")
}
