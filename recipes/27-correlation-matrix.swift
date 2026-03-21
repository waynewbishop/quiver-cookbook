import Playgrounds
import Quiver

// Correlation Matrix
// Correlation measures how two variables move together.
// +1.0 = they rise and fall in lockstep (strong positive).
// -1.0 = when one rises, the other falls (strong negative).
//  0.0 = no relationship at all.

#Playground("Correlation Matrix") {

    // Five days of data: temperature (°F) and ice cream sales ($)
    let temperature = [75.0, 80.0, 85.0, 70.0, 90.0]
    let iceCreamSales = [200.0, 240.0, 300.0, 180.0, 320.0]

    // Correlation matrix: compare every variable against every other
    // The result is a square matrix — diagonal is always 1.0 (perfect self-correlation)
    let corr = [temperature, iceCreamSales].correlationMatrix()

    // corr[0][0] = 1.0 (temperature vs itself)
    // corr[0][1] = temperature vs ice cream sales (~0.98 — strong positive)
    // corr[1][0] = same as [0][1] (symmetric)
    // corr[1][1] = 1.0 (ice cream vs itself)

    print("Correlation matrix:")
    print("  Temp vs Temp:      \(String(format: "%.4f", corr[0][0]))")
    print("  Temp vs Ice Cream: \(String(format: "%.4f", corr[0][1]))")
    print("  Ice Cream vs Temp: \(String(format: "%.4f", corr[1][0]))")

    // A correlation near 1.0 means: hotter days → more ice cream sales
    // Useful before ML: highly correlated features may be redundant
}
