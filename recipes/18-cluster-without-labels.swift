import Playgrounds
import Quiver

// Cluster Without Labels
// K-Means finds natural groupings in data that has no labels.
// You tell it how many clusters (k) to look for. It assigns
// each point to the nearest centroid, then adjusts centroids
// until they stabilize.

#Playground("Cluster Without Labels") {

    // Unlabeled 2D data — three natural groups visible to humans
    let data: [[Double]] = [
        [1.0, 2.0], [1.5, 1.8], [1.2, 2.1],    // group A
        [5.0, 5.0], [5.5, 4.8], [4.8, 5.2],    // group B
        [9.0, 8.0], [8.5, 8.5], [9.2, 7.8]     // group C
    ]

    // Fit: iteratively assigns points to clusters and moves centroids
    let model = KMeans.fit(data: data, k: 3, seed: 42)

    // Which cluster did each point land in?
    print("Labels: \(model.labels)")  // e.g. [0, 0, 0, 1, 1, 1, 2, 2, 2]

    // Where are the cluster centers?
    let clusters = model.clusters(from: data)
    for (i, cluster) in clusters.enumerated() {
        print("Cluster \(i): center = \(cluster.centroid), size = \(cluster.count)")
    }

    // How many iterations did it take to converge?
    print("Converged in \(model.iterations) iterations")
}
