import Playgrounds
import Quiver

// Cluster Without Labels
// K-Means uses the same vector math from earlier recipes:
// distance(to:) (Recipe 1) assigns each point to its nearest
// centroid, and meanVector() recomputes centroids as the average
// position of each group. This loop — measure distance, regroup,
// recalculate center — repeats until the clusters stabilize.

#Playground("Cluster Without Labels") {

    // Unlabeled 2D data — three natural groups visible to humans
    let data: [[Double]] = [
        [1.0, 2.0], [1.5, 1.8], [1.2, 2.1],    // group A
        [5.0, 5.0], [5.5, 4.8], [4.8, 5.2],    // group B
        [9.0, 8.0], [8.5, 8.5], [9.2, 7.8]     // group C
    ]

    // Fit: each iteration uses distance(to:) to assign points,
    // then meanVector() to move centroids — the same operations
    // from Recipes 1 and 7, applied in a loop until convergence
    let model = KMeans.fit(data: data, k: 3, seed: 42)

    // print() gives a clean summary thanks to CustomStringConvertible
    print(model)  // KMeans: 3 clusters, 9 points, converged in N iterations

    // Dig deeper — each cluster also prints cleanly
    let clusters = model.clusters(from: data)
    for cluster in clusters {
        print(cluster)  // Cluster: center [...], 3 points
    }

    // Individual properties still accessible for detailed inspection
    print("Labels: \(model.labels)")  // [0, 0, 0, 1, 1, 1, 2, 2, 2]
}
