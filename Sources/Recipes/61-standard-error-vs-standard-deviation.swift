import Playgrounds
import Quiver
import Foundation

// Standard Error vs Standard Deviation
// The standard deviation describes the *data* — how far values
// spread from the mean of this sample. The standard error
// describes the *estimate* — how much the sample mean itself
// would wobble if we drew another sample of the same size.
// SE = SD / √n, so SE always shrinks as the sample grows;
// SD does not. Mixing the two is the most common stats mistake
// in applied work.

#Playground("Standard Error vs Standard Deviation") {

    // Reported heights (cm) from a small classroom sample
    let heights = [168.0, 172.0, 165.0, 178.0, 170.0, 169.0, 174.0,
                   167.0, 171.0, 173.0, 166.0, 175.0, 170.0, 169.0, 172.0]

    let n = heights.count
    let mean = heights.mean() ?? 0
    let sd = heights.standardDeviation() ?? 0
    let se = heights.standardError() ?? 0

    print("n:    \(n)")
    print("mean: \(String(format: "%.2f", mean)) cm")
    print("sd:   \(String(format: "%.4f", sd)) cm   — spread of the heights themselves")
    print("se:   \(String(format: "%.4f", se)) cm   — uncertainty in the sample mean")
    print()
    print("SD × √n = \(String(format: "%.4f", sd * Foundation.sqrt(Double(n)))) cm")
    print("Confirms: se = sd / √n — both report different things")
}
