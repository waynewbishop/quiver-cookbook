import Playgrounds
import Quiver

// Multiply Two Matrices
// Matrix multiplication combines rows from the first matrix
// with columns from the second using dot products.
// Each output cell is the dot product of one row and one column.

#Playground("Multiply Two Matrices") {

    // Matrix A: 2 rows × 3 columns
    let A: [[Double]] = [
        [1.0, 2.0, 3.0],
        [4.0, 5.0, 6.0]
    ]

    // Matrix B: 3 rows × 2 columns
    let B: [[Double]] = [
        [7.0,  8.0],
        [9.0,  10.0],
        [11.0, 12.0]
    ]

    // Result: 2 rows × 2 columns
    // Cell [0][0] = row 0 of A · column 0 of B
    //             = (1×7) + (2×9) + (3×11) = 7 + 18 + 33 = 58
    let result = A.multiplyMatrix(B)
    // [[58.0, 64.0], [139.0, 154.0]]

    print("A × B = \(result)")
    print("Cell [0][0] = \(result[0][0])")  // 58.0
    print("Cell [0][1] = \(result[0][1])")  // 64.0
    print("Cell [1][0] = \(result[1][0])")  // 139.0
    print("Cell [1][1] = \(result[1][1])")  // 154.0
}
