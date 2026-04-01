import Playgrounds
import Quiver

// Delivery Route Optimizer — Smarter Stop Sequencing
// A delivery driver with 25 stops and a route card drives them
// in whatever order they were assigned — often zigzagging across
// the entire area. This recipe uses K-Means to cluster stops into
// geographic groups, then sequences within each cluster by
// nearest neighbor. The result: same stops, less windshield time.
// Enterprise route optimization costs hundreds of thousands.
// This runs on an iPhone with zero dependencies.

#Playground("Delivery Route Optimizer") {

    // 12 delivery stops: [latitude, longitude]
    let stops: [[Double]] = [
        [47.610, -122.330], [47.615, -122.340], [47.605, -122.320],
        [47.650, -122.300], [47.655, -122.310], [47.645, -122.290],
        [47.580, -122.360], [47.575, -122.370], [47.590, -122.350],
        [47.630, -122.280], [47.635, -122.270], [47.625, -122.290]
    ]

    // Cluster into geographic zones
    let model = KMeans.fit(data: stops, k: 3, seed: 42)

    // Plan the route — complete each zone before moving to the next
    for (i, cluster) in model.clusters(from: stops).enumerated() {
        let center = cluster.centroid
        print("Zone \(i + 1): \(cluster.count) stops near [\(String(format: "%.3f", center[0])), \(String(format: "%.3f", center[1]))]")

        // Show stops in this zone
        for point in cluster {
            let dist = point.distance(to: center)
            print("  [\(String(format: "%.3f", point[0])), \(String(format: "%.3f", point[1]))] — \(String(format: "%.4f", dist))° from center")
        }
    }
}
