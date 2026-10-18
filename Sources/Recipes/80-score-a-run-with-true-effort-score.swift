import Playgrounds
import Quiver
import Foundation

// Score a Run with True Effort Score
// Recipes 51, 52, and 59 taught the primitives — dominant frequencies,
// grade from elevation. TrueEffortScore is the model they build toward,
// and recipe 41 shows what an app does with its result afterward.
// TES reads six signals per moment (heart rate, pace, cadence, grade,
// vertical oscillation, altitude), classifies each
// moment from Recovery to Hard, and sums the labeled moments into a
// score. One hour at Threshold reads 100; there is no ceiling.
//
// The classifier is seeded from built-in anchor efforts, so a score
// exists from the very first run. The personal baseline — the heart
// rate YOUR workload should produce — is learned later, from your own
// history. On a first run there is no baseline and no residual.

#Playground("Score a Run with True Effort Score") {

    var tes = TrueEffortScore()   // first run: no personal history yet
    let start = Date()

    // A 20-minute trail run sampled every 5 seconds (240 samples).
    // First half: steady running on gentle ground.
    // Second half: a -6% descent — heart rate stays calm, but the
    // quadriceps are braking every foot strike. A heart-rate-only
    // model calls this an easy day; TES prices the eccentric load.
    for i in 0..<240 {
        let descending = i >= 120
        let t = start.addingTimeInterval(Double(i) * 5)

        tes.record(
            heartRate: descending ? 138.0 : 150.0,          // bpm
            pace: descending ? 5.1 : 5.6,                   // min/km
            cadence: descending ? 178.0 : 172.0,            // steps/min
            grade: descending ? -6.0 : 0.5,                 // percent, negative = downhill
            verticalOscillation: descending ? 9.2 : 7.8,    // cm
            altitude: 100.0 - (descending ? Double(i - 120) * 0.3 : 0.0),  // meters
            at: t
        )
    }

    // finalize() closes the run and returns nil under 60 seconds of
    // active time — too short to score.
    guard let result = tes.finalize() else { return }

    // print() shows the full breakdown: headline score, raw score,
    // heart rates, and every session adjustment on its own line.
    print(result)

    // Where did the time go? The descent minutes should read Hard
    // even though heart rate stayed calm — that is the whole point.
    for category in EffortClass.allCases {
        let seconds = result.time(in: category)
        if seconds > 0 {
            print("\(category): \(Int(seconds / 60)) min")
        }
    }

    // No residual yet — the baseline is learned from this run's history
    // and starts predicting on future runs. After a few weeks of runs,
    // result.meanResidual reports observed − expected heart rate,
    // separating heat and fatigue from the mechanical workload.
    print("Mean residual: \(result.meanResidual as Any)")   // nil on a first run
    print("Baseline: \(tes.baseline?.equation() ?? "not learned yet")")
}
