import Playgrounds
import Quiver

// Organize Data with Panel
// Panel gives your data named columns — like a spreadsheet
// where each column has a label. This makes it easy to inspect,
// filter, split, and feed data into ML models without losing
// track of which numbers mean what.

#Playground("Organize Data with Panel") {

    // Create a Panel with named columns
    let data = Panel([
        ("age",     [25.0, 45.0, 35.0, 52.0, 23.0, 41.0, 33.0, 28.0]),
        ("income",  [35000.0, 72000.0, 55000.0, 88000.0, 28000.0, 65000.0, 48000.0, 38000.0]),
        ("score",   [620.0, 750.0, 680.0, 790.0, 590.0, 720.0, 660.0, 640.0])
    ])

    // print() gives a quick summary of the structure
    print(data)  // Panel: 3 columns, 8 rows

    // describe() gives detailed column statistics
    print(data.describe())

    // Access a single column by name
    let ages = data["age"]        // [25.0, 45.0, 35.0, ...]
    let avgAge = ages.mean()      // ~35.25
    print("Average age: \(avgAge ?? 0)")

    // Filter: keep only rows where score > 650
    let highScore = data["score"].isGreaterThan(650.0)
    let qualified = data.filtered(where: highScore)
    print("Qualified rows: \(qualified.rowCount)")

    // Split for ML: 80% train, 20% test — columns stay aligned
    let (train, test) = data.trainTestSplit(testRatio: 0.2, seed: 42)

    // Convert to matrix for model input
    let features = train.toMatrix(columns: ["age", "income"])

    print("Training rows: \(train.rowCount), Test rows: \(test.rowCount)")
    print("Feature matrix: \(features.count) rows × \(features[0].count) columns")
}
