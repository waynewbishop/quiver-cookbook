import Playgrounds
import Quiver

// Testing Equality
// Quiver's models and results support direct comparison with ==.
// When two training runs use the same data and the same seed,
// the models are guaranteed identical. No need to check each
// property manually — this is useful for unit tests, debugging,
// and confirming that a pipeline produces stable output.

#Playground("Testing Equality") {

    // Three natural groups in 2D space
    let data: [[Double]] = [
        [1.0, 2.0], [1.5, 1.8], [1.2, 2.1],
        [5.0, 5.0], [5.5, 4.8], [4.8, 5.2],
        [9.0, 8.0], [8.5, 8.5], [9.2, 7.8]
    ]

    // Train twice with the same seed
    let run1 = KMeans.fit(data: data, k: 3, seed: 42)
    let run2 = KMeans.fit(data: data, k: 3, seed: 42)

    // Models are equal — same centroids, labels, and inertia
    print(run1 == run2)  // true

    // Clusters can also test for equality
    let clusters1 = run1.clusters(from: data)
    let clusters2 = run2.clusters(from: data)
    print(clusters1 == clusters2)  // true

    // A different seed produces a different model
    let run3 = KMeans.fit(data: data, k: 3, seed: 99)
    print(run1 == run3)  // false
}
