import Playgrounds
import Quiver

// Bimodal Detection with mode()
// Some distributions are bimodal — two clusters share the highest
// frequency. A scalar mode would silently pick one. mode() returns
// [Element], so the "two-headed" shape surfaces as a multi-element
// array. Pair with a histogram to see why.

#Playground("Bimodal Detection with mode()") {

    // Mixing two populations: shorter and taller groups
    let heights: [Double] = [
        162, 164, 162, 163, 162, 165, 164, 162,     // shorter group
        178, 180, 179, 181, 180, 178, 180, 179      // taller group
    ]

    let modes = heights.mode()
    print("Modes: \(modes)")  // [162.0, 180.0] — two values tied

    if modes.count > 1 {
        print("This distribution is multimodal — \(modes.count) values share the highest frequency.")
    }

    // The histogram makes the two-cluster shape visible
    print()
    print("Histogram:")
    for bin in heights.histogram(bins: 8) {
        let bar = String(repeating: "█", count: bin.count)
        print("  \(String(format: "%6.1f", bin.midpoint)): \(bar) (\(bin.count))")
    }
}
