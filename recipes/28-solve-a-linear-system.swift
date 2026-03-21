import Playgrounds
import Quiver

// Solve a Linear System
// Many real-world problems reduce to a set of equations:
//   2x + 3y = 16
//   4x + 1y = 12
// In matrix form: A × x = b. If A is invertible, x = A⁻¹ × b.
// The matrix inverse "undoes" A, isolating the unknowns.

#Playground("Solve a Linear System") {

    // A store sells two products. From two days of sales data:
    //   Day 1: 2 shirts + 3 hats = $160 revenue
    //   Day 2: 4 shirts + 1 hat  = $120 revenue
    // What is the price of each item?

    // Coefficients matrix A (quantities sold)
    let A: [[Double]] = [
        [2.0, 3.0],   // Day 1: 2 shirts, 3 hats
        [4.0, 1.0]    // Day 2: 4 shirts, 1 hat
    ]

    // Results vector b (total revenue each day)
    let b: [[Double]] = [
        [160.0],
        [120.0]
    ]

    // Solve: x = A⁻¹ × b
    // The inverse "undoes" the mixing of quantities,
    // revealing the individual prices
    if let A_inv = A.inverted() {
        let prices = A_inv.multiplyMatrix(b)

        // prices[0][0] = shirt price, prices[1][0] = hat price
        print("Shirt: $\(prices[0][0])")  // $20.0
        print("Hat:   $\(prices[1][0])")  // $40.0

        // Verify: plug prices back into original equations
        let check = A.multiplyMatrix(prices)
        print("Verify Day 1: $\(check[0][0])")  // 160.0
        print("Verify Day 2: $\(check[1][0])")  // 120.0
    }
}
