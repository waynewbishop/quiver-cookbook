import Playgrounds
import Quiver

// Describe a Dataset
// One array of exam scores, complete statistical profile.
// These are the first questions any data scientist asks about new data.

#Playground("Describe a Dataset") {

    // Exam scores for a class of 12 students
    let scores = [72.0, 85.0, 91.0, 68.0, 95.0, 88.0, 76.0, 82.0, 79.0, 93.0, 65.0, 87.0]

    // Central tendency — where is the middle?
    let avg = scores.mean()     // ~81.75 — the arithmetic average
    let mid = scores.median()   // ~83.5 — the middle value (less sensitive to extremes)

    // Spread — how much variation exists?
    let sd = scores.std()       // ~9.7 — typical distance from the mean
    let v = scores.variance()   // ~93.5 — standard deviation squared

    // Distribution — where do the boundaries fall?
    // Quartiles divide data into four equal groups
    if let q = scores.quartiles() {
        print("Min:    \(q.min)")       // 65.0 — lowest score
        print("Q1:     \(q.q1)")        // 74.0 — 25th percentile
        print("Median: \(q.median)")    // 83.5 — 50th percentile
        print("Q3:     \(q.q3)")        // 90.25 — 75th percentile
        print("Max:    \(q.max)")       // 95.0 — highest score
        print("IQR:    \(q.iqr)")       // 16.25 — middle 50% range
    }

    print("Mean: \(avg ?? 0), Median: \(mid ?? 0)")
    print("Std: \(String(format: "%.2f", sd ?? 0)), Variance: \(String(format: "%.2f", v ?? 0))")
}
