import Playgrounds
import Quiver

// Wing Panel Rivet Inspection
// A Boeing 787 contains roughly 2.3 million parts. Rivet holes on
// wing panels must meet tolerances within ±0.030 inches — hole
// diameter, countersink depth, and head flushness are all measured.
// A single out-of-tolerance rivet can require an entire panel to be
// reworked. At 10-20% rework rates, catching defects early saves
// millions. This recipe simulates a quality control station that
// classifies rivets as pass or fail using Gaussian Naive Bayes.
// Educational only — real aerospace QC uses machine vision, 3D
// laser scanning, and dozens of additional parameters.

#Playground("Wing Panel Rivet Inspection") {

    // Inspection readings: [hole diameter (mm), countersink depth (mm), flushness (mm)]
    // Rivets within tolerance pass. Oversized or protruding rivets fail.
    let readings: [[Double]] = [
        [4.76, 1.20, 0.00], [4.77, 1.19, 0.01], [4.75, 1.21, 0.00],
        [4.76, 1.18, 0.01], [4.78, 1.20, 0.00], [4.75, 1.22, 0.01],
        [4.85, 1.30, 0.05], [4.82, 1.28, 0.04], [4.88, 1.32, 0.06]
    ]
    let labels = [0, 0, 0, 0, 0, 0, 1, 1, 1]  // 0 = pass, 1 = fail

    // Train on labeled inspection data
    let model = GaussianNaiveBayes.fit(features: readings, labels: labels)
    print(model)

    // A new rivet comes off the line — is it safe to fly?
    let newRivet = [[4.80, 1.25, 0.03]]
    let decision = model.predict(newRivet)
    print(decision[0] == 0 ? "PASS — within tolerance" : "FAIL — flag for reinspection")
}
