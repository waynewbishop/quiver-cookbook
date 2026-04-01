import Playgrounds
import Quiver

// Recovery Prediction — How Hard Will Tomorrow Morning Feel?
// After a run, resting heart rate rises. A flat easy run might
// elevate resting HR by 2 BPM overnight. A hard hilly run might
// elevate it by 8 BPM. This recipe trains a regression model
// on past run profiles to predict next-morning HR elevation —
// a proxy for recovery load that the watch measures automatically.
// No manual entry, no subjective guessing.

#Playground("Recovery Prediction") {

    // Historical runs: [rss, pct_uphill, pct_downhill, avg_power, max_power]
    let history: [[Double]] = [
        [60,  10, 5,  220, 250],   // easy flat
        [85,  60, 10, 255, 290],   // uphill heavy
        [90,  5,  50, 230, 260],   // downhill heavy
        [75,  20, 20, 240, 270],   // mixed
        [100, 70, 5,  265, 300],   // hard uphill
        [50,  5,  5,  210, 235],   // easy flat
        [95,  15, 15, 250, 285],   // hard flat
        [80,  45, 25, 245, 280],   // hilly
    ]

    // Next-morning resting HR elevation (BPM above baseline)
    // Measured automatically by the watch — no manual entry
    let hrElevation = [2.0, 8.0, 7.0, 4.0, 10.0, 1.0, 5.0, 6.0]

    // Train on the relationship between effort profile and recovery cost
    let model = try LinearRegression.fit(features: history, targets: hrElevation)
    print(model)

    // Today's run: RSS 88, 55% uphill
    let todaysRun = [[88.0, 55, 10, 258, 295]]
    let prediction = model.predict(todaysRun)
    print("Predicted HR elevation: +\(String(format: "%.0f", prediction[0])) BPM")

    // Same RSS but flat — less recovery cost
    let flatRun = [[88.0, 5, 5, 248, 275]]
    let flatPrediction = model.predict(flatRun)
    print("Same RSS, flat run:    +\(String(format: "%.0f", flatPrediction[0])) BPM")
}
