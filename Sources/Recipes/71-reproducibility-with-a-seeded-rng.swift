import Playgrounds
import Quiver

// Reproducibility with SeededRandomNumberGenerator
// Random work that grades, debugs, or publishes needs to be
// reproducible. SeededRandomNumberGenerator is a struct
// conforming to RandomNumberGenerator — pass it by inout to
// every random method, and two runs with the same seed produce
// the same numbers. Across the entire Quiver random surface
// AND the Swift standard library's `using:` overloads.

#Playground("Reproducibility with a Seeded RNG") {

    // Two RNGs initialized with the same seed
    var rng1 = SeededRandomNumberGenerator(seed: 42)
    var rng2 = SeededRandomNumberGenerator(seed: 42)

    // Identical random arrays
    let a = [Double].randomNormal(5, mean: 0, standardDeviation: 1, using: &rng1)
    let b = [Double].randomNormal(5, mean: 0, standardDeviation: 1, using: &rng2)
    print("rng1: \(a)")
    print("rng2: \(b)")
    print("identical:", a == b)
    print()

    // Same seed, different distributions — still reproducible
    var rngExp = SeededRandomNumberGenerator(seed: 100)
    let waits = [Double].randomExponential(5, rate: 1.0, using: &rngExp)
    print("exponential (seed 100): \(waits)")

    // Reproducible across stdlib methods that take `using:` too
    var rngShuffle = SeededRandomNumberGenerator(seed: 7)
    let shuffled = [1, 2, 3, 4, 5].shuffled(using: &rngShuffle)
    print("shuffled (seed 7): \(shuffled)")

    print()
    print("Every random method advances the generator's state. Pass it")
    print("by inout so subsequent calls see the advanced state — passing")
    print("by value would replay the same numbers on every call.")
}
