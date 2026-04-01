import Playgrounds
import Quiver

// True Effort — Multi-Signal Running Classification
// A heart rate of 160 BPM means different things depending on
// context. Running uphill at a slow pace is harder than cruising
// downhill at the same heart rate. This recipe trains a model on
// four sensor signals — heart rate, cadence, pace, and elevation
// change — to classify true effort, not just heart rate zones.
// The result: "Your HR says Zone 4, but your actual effort is
// Zone 2 — the hill is inflating your heart rate."

#Playground("True Effort Classification") {

    // Training data: [heart rate, cadence (spm), pace (min/km), elevation delta (m)]
    // Each row is a moment from a training run, labeled by perceived effort
    let readings: [[Double]] = [
        [130, 165, 6.5, 0.0],  [135, 168, 6.2, 0.0],  [128, 162, 6.8, -1.0],
        [150, 172, 5.5, 1.0],  [155, 174, 5.3, 1.5],  [148, 170, 5.8, 0.5],
        [160, 165, 6.5, -3.0], [158, 163, 6.8, -2.5], [162, 167, 6.2, -2.0],
        [170, 180, 4.8, 0.0],  [175, 182, 4.5, 0.5],  [172, 178, 4.6, 0.0]
    ]

    // Perceived effort labels from the runner
    // 0 = easy, 1 = moderate, 2 = tempo, 3 = hard
    let effort = [0, 0, 0, 1, 1, 1, 0, 0, 0, 3, 3, 3]
    //                                ^^^
    // Key insight: rows 6-8 have HR ~160 but effort is EASY (0)
    // because pace is slow and elevation is downhill.
    // A pure HR zone model would call this Zone 4.

    // Scale so HR (130-175) doesn't dominate cadence (162-182)
    let scaler = FeatureScaler.fit(features: readings)
    let scaled = scaler.transform(readings)

    // Train on the full sensor picture, not just heart rate
    let model = KNearestNeighbors.fit(
        features: scaled, labels: effort, k: 3,
        metric: .euclidean, weight: .distance
    )

    // New reading: HR is 160 — but we're jogging downhill
    let now = scaler.transform([[160, 164, 6.5, -2.5]])
    let trueEffort = model.predict(now)[0]

    let zones = ["Easy", "Moderate", "Tempo", "Hard"]
    print("HR: 160 BPM")
    print("HR zone says: \(zones[2])")
    print("True effort:  \(zones[trueEffort])")
}
