import Playgrounds
import Quiver

// Recovery Prediction — How Hard Will Tomorrow Morning Feel?
// After a run, resting heart rate rises. An easy jog might elevate
// resting HR by 1 BPM overnight; a hard interval session might push
// it up 8 BPM. True Effort Score (recipe 80) already measures what a
// run cost in the moment. This recipe trains a regression model on
// past TES results to predict next-morning HR elevation — a proxy
// for recovery cost that the watch measures automatically.
// No manual entry, no subjective guessing.

#Playground("Recovery Prediction") {

    // Historical runs, one row per finalized TESResult:
    //   adjusted       — result.adjusted, the headline score
    //   thresholdShare — effortDistribution[.threshold] + [.hard]
    //   meanResidual   — result.meanResidual, bpm above expected
    // TES already prices climbs and descents in the score and the
    // effort distribution, so no separate terrain columns are needed.
    let history: [[Double]] = [
        [45,  0.00,  0.5],   // easy
        [72,  0.05,  1.0],   // long easy
        [88,  0.35,  0.0],   // threshold session
        [64,  0.20,  1.5],   // hilly mixed
        [105, 0.55,  2.0],   // hard intervals
        [38,  0.00, -0.5],   // recovery jog
        [80,  0.15,  6.0],   // steady run, hot afternoon
        [96,  0.40,  4.5],   // hard trail with a long descent, warm
    ]

    // Next-morning resting HR elevation (BPM above baseline)
    // Measured automatically by the watch — no manual entry
    let hrElevation = [1.5, 3.5, 4.5, 4.0, 8.0, 1.0, 5.5, 7.5]

    // Train on the relationship between the TES breakdown and recovery cost
    let model = try LinearRegression.fit(features: history, targets: hrElevation)
    print(model)

    // Today's run: TES 85, 30% of the time at threshold or harder
    let todaysRun = [[85.0, 0.30, 1.0]]
    let prediction = model.predict(todaysRun)
    print("Predicted HR elevation: +\(String(format: "%.0f", prediction[0])) BPM")   // +5

    // Same score, same distribution, but heart rate ran 7 bpm above
    // expected — a hot day. TES keeps the residual out of the headline,
    // so the score stays 85; the recovery model reads it separately.
    let hotRun = [[85.0, 0.30, 7.0]]
    let hotPrediction = model.predict(hotRun)
    print("Same TES, hot day:      +\(String(format: "%.0f", hotPrediction[0])) BPM")   // +7

    // summary() reports which columns actually drove the prediction.
    // With only 8 training samples, only the residual is confidently
    // non-zero; the intervals on the score and threshold share cross
    // zero. That is itself the lesson: small training sets give wide
    // confidence intervals. Hold out a test set in production.
    let report = try model.summary(features: history, targets: hrElevation)
    print(report)
}
