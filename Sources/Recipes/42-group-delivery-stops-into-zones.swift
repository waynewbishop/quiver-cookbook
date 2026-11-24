// Copyright 2026 Wayne W Bishop. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

import Foundation
import Playgrounds
import Quiver

// Group Delivery Stops into Zones
// K-Means groups stop coordinates into three zones and reports each
// stop's distance from its zone center in coordinate degrees.

#Playground("Group Delivery Stops into Zones") {
    // 12 delivery stops: [latitude, longitude]
    let stops: [[Double]] = [
        [47.610, -122.330], [47.615, -122.340], [47.605, -122.320],
        [47.650, -122.300], [47.655, -122.310], [47.645, -122.290],
        [47.580, -122.360], [47.575, -122.370], [47.590, -122.350],
        [47.630, -122.280], [47.635, -122.270], [47.625, -122.290]
    ]

    // Cluster into geographic zones
    let model = KMeans.fit(data: stops, k: 3, seed: 42)

    // List the stops assigned to each zone.
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
