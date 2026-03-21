import Playgrounds
import Quiver

// Reshape Without Losing Data
// Reshaping changes how numbers are organized in rows and columns.
// No data is added or removed — the same values flow into a new shape,
// filling row by row.

#Playground("Reshape Without Losing Data") {

    // 12 numbers as a flat vector
    let flat = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0]

    // Reshape into different grids — same 12 values every time
    let matrix3x4 = flat.reshaped(rows: 3, columns: 4)
    // [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]

    let matrix4x3 = flat.reshaped(rows: 4, columns: 3)
    // [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]

    let matrix2x6 = flat.reshaped(rows: 2, columns: 6)
    // [[1, 2, 3, 4, 5, 6], [7, 8, 9, 10, 11, 12]]

    // Flatten back to the original vector — nothing lost
    let restored = matrix3x4.flattened()  // [1, 2, 3, ..., 12]

    print("3×4: \(matrix3x4)")
    print("4×3: \(matrix4x3)")
    print("2×6: \(matrix2x6)")
    print("Flat: \(restored)")
    print("Same data? \(flat == restored)")  // true
}
