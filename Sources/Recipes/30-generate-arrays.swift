import Playgrounds
import Quiver

// Generate Arrays
// Numerical computing starts with creating arrays of specific
// shapes and values. Instead of writing loops or literals,
// generation functions produce arrays from a description:
// "give me 5 zeros" or "100 values evenly spaced from 0 to 10."

#Playground("Generate Arrays") {

    // Constant arrays — useful for initializing accumulators or baselines
    let z = [Double].zeros(5)           // [0.0, 0.0, 0.0, 0.0, 0.0]
    let o = [Double].ones(4)            // [1.0, 1.0, 1.0, 1.0]
    print("Zeros: \(z)")
    print("Ones:  \(o)")

    // Evenly spaced values — the foundation of plotting and interpolation
    // linspace: specify start, end, and how many points you want
    let x = [Double].linspace(start: 0.0, end: 10.0, count: 5)
    // [0.0, 2.5, 5.0, 7.5, 10.0]
    print("Linspace: \(x)")

    // arange: specify start, stop, and step size
    let steps = [Double].arange(0.0, 1.0, step: 0.2)
    // [0.0, 0.2, 0.4, 0.6, 0.8]
    print("Arange: \(steps)")

    // 2D arrays — matrices initialized with zeros or ones
    let matrix = [Double].zeros(3, 4)  // 3 rows × 4 columns of zeros
    print("Matrix shape: \(matrix.count) × \(matrix[0].count)")

    // Random generation is its own topic — see Recipe 69 (exponential
    // arrivals), Recipe 70 (binomial A/B simulation), and Recipe 71
    // (seeded, reproducible randomness).
}
