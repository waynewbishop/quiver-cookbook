import Playgrounds
import Quiver
import Foundation

// Running Stress Breakdown — What's Behind the Number?
// Training stress scores seen on most running watches condense an entire run
// into one number. That number is useful for tracking load over
// time, but it hides the story. This recipe computes a stress
// score then uses K-Means to decompose the run into effort
// clusters — revealing whether the stress came from flat
// cruising, uphill grinding, or downhill impact. Same score,
// very different recovery implications.

#Playground("Running Stress Breakdown") {

    // Critical Power — the runner's personal threshold (watts)
    let criticalPower = 250.0

    // Simulated run segments: [power, grade %, cadence, ground contact ms]
    let segments: [[Double]] = [
        [230, 0.0, 178, 245], [235, 0.5, 176, 248],   // flat warmup
        [260, 4.0, 170, 265], [270, 5.0, 168, 272],   // uphill grind
        [220, -3.0, 182, 230], [215, -4.0, 184, 225], // downhill impact
        [245, 0.0, 180, 240], [250, 1.0, 179, 242],   // flat tempo
    ]

    // Overall stress score: 100 × hours × (power/CP)^2
    let powers = segments.column(at: 0)
    let avgRatio = (powers.mean()! / criticalPower)
    let durationHours = 0.75
    
    // 1 hour at critical power = 100 points. Higher intensity scales exponentially.
    let rss = 100.0 * durationHours * pow(avgRatio, 2.0)
    
    print("Overall RSS: \(String(format: "%.0f", rss))")

    // Decompose: what kind of stress was it?
    let scaler = FeatureScaler.fit(features: segments)
    let scaled = scaler.transform(segments)
    
    // Train the model
    let model = KMeans.fit(data: scaled, k: 3, seed: 42)

    // Show the effort clusters with average power and grade
    for cluster in model.clusters(from: segments) {
        let avgPower = cluster.points.column(at: 0).mean() ?? 0
        let avgGrade = cluster.points.column(at: 1).mean() ?? 0
        
        print("\(cluster.count) segments: avg \(String(format: "%.0f", avgPower))W, grade \(String(format: "%.1f", avgGrade))%")
        
    }
}
