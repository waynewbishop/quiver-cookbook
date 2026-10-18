import Playgrounds
import Quiver

// Solve a Linear System
// Many real-world problems reduce to a set of equations:
//   2x + 3y = 160
//   4x + 1y = 120
// In matrix form: A × x = b. You could compute x = A⁻¹ × b by hand
// (Recipe 14), but solve() goes straight to the answer — and avoids
// forming the inverse at all, which is both faster and numerically
// more stable. In practice: never invert a matrix to solve a system.

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
    let b = [160.0, 120.0]

    // Solve directly — returns nil if the system has no unique
    // solution (a singular A, the same condition Recipe 14 detects
    // with the determinant)
    if let prices = A.solve(b) {
        print("Shirt: $\(prices[0])")  // $20.0
        print("Hat:   $\(prices[1])")  // $40.0

        // Verify: plug prices back into the original equations
        let check = A.multiplyMatrix(prices.map { [$0] })
        print("Verify Day 1: $\(check[0][0])")  // 160.0
        print("Verify Day 2: $\(check[1][0])")  // 120.0
    }
}
