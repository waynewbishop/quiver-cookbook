import Playgrounds
import Quiver

// How Far Is Home?
// Magnitude and distance both use the Pythagorean theorem,
// but they answer different questions.

#Playground("How Far Is Home?") {

    // Magnitude answers: "how far am I from the origin (home)?"
    // For vector [3, 4], that's √(3² + 4²) = √(9 + 16) = √25 = 5.0
    let position = [3.0, 4.0]
    let distanceFromHome = position.magnitude  // 5.0

    // Distance answers: "how far is point A from point B?"
    // From [1, 2] to [4, 6]: √((4-1)² + (6-2)²) = √(9 + 16) = 5.0
    let library = [1.0, 2.0]
    let coffeeShop = [4.0, 6.0]
    let gap = library.distance(to: coffeeShop)  // 5.0

    // Both equal 5.0 — same theorem, different starting points.
    // Magnitude always starts at origin [0, 0].
    // Distance starts at any point you choose.
    let origin = [0.0, 0.0]
    let proof = origin.distance(to: position)  // 5.0 (same as magnitude)

    print("Magnitude: \(distanceFromHome)")       // 5.0
    print("Distance:  \(gap)")                     // 5.0
    print("Proof:     \(proof)")                   // 5.0
}
