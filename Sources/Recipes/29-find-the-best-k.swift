import Playgrounds
import Quiver

// Find the Best K (Elbow Method)
// K-Means (Recipe 18) requires choosing K — the number of clusters.
// The elbow method runs K-Means for each K and measures inertia:
// the total squared distance from each point to its centroid.
// That distance is the same Pythagorean calculation from Recipe 1.
// The "elbow" — where inertia drops sharply then levels off —
// reveals the natural number of groups in the data.

#Playground("Find the Best K") {

    // Data with three natural clusters
    let data: [[Double]] = [
        [1.0, 2.0], [1.5, 1.8], [1.2, 2.1], [1.3, 1.9],
        [5.0, 5.0], [5.5, 4.8], [4.8, 5.2], [5.2, 5.1],
        [9.0, 8.0], [8.5, 8.5], [9.2, 7.8], [8.8, 8.2]
    ]

    // Run K-Means for k = 1 through 6 and collect inertia scores
    // Inertia = sum of squared distances from each point to its centroid
    // Lower inertia = tighter clusters
    let inertias = KMeans.elbowMethod(data: data, kRange: 1...6, seed: 42)

    // Print the elbow curve
    for result in inertias {
        let bar = String(repeating: "█", count: Int(result.inertia / 5))
        print("k=\(result.k): \(String(format: "%6.1f", result.inertia)) \(bar)")
    }

    // Look for the "elbow" — where inertia drops sharply then levels off
    // k=3 is typically the elbow for this data (three natural groups)
    // Going from k=2 to k=3 shows a big drop; k=3 to k=4 shows little gain
}
