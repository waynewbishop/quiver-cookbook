import Playgrounds
import Quiver

// Compress a Dataset with PCA
// Real datasets carry redundant columns — square footage, bedrooms,
// and lot size all move together, so they partly say the same thing.
// Principal Component Analysis rotates the data onto new axes ordered
// by how much variation each one captures, then keeps only the top few.
// The result: fewer columns, most of the signal.
//
// PCA is unsupervised — it never sees labels. It is also a Pipeline
// reducer stage (Recipe 46), so the same rotation learned on the
// training set applies identically at predict time.

#Playground("Compress a Dataset with PCA") {

    // Eight homes, four correlated features:
    // [square feet, bedrooms, lot size (1000s sqft), age in years]
    // The first three move together — big houses have more bedrooms
    // and bigger lots — so one axis will capture most of their story.
    let features: [[Double]] = [
        [1100, 2, 4.0, 15],
        [1400, 3, 5.5, 10],
        [1550, 3, 6.0, 7],
        [1700, 4, 6.5, 8],
        [1875, 4, 7.0, 3],
        [2350, 4, 9.0, 2],
        [2450, 5, 9.5, 1],
        [1200, 2, 4.5, 12]
    ]

    // Fit: finds the axes of greatest variation, ranked
    let pca = PCA.fit(features: features, componentCount: 2)
    print(pca)  // PCA: 4 features → 2 components

    // How much of the data's variation does each component capture?
    // Ratios sum across all four original axes to 1.0; the first two
    // should carry nearly all of it.
    print("Variance explained: \(pca.explainedVarianceRatios)")
    // e.g. [0.97, 0.02] — the first axis is almost the whole story

    // Transform: project the 4-column data onto the 2 kept axes
    let reduced = pca.transform(features)
    print("Original shape: \(features.count) × \(features[0].count)")
    print("Reduced shape:  \(reduced.count) × \(reduced[0].count)")

    // inverseTransform maps back to the original space — approximately.
    // What was dropped (the last ~1% of variance) does not come back,
    // which is exactly the compression.
    let restored = pca.inverseTransform(reduced)
    print("Original row 0:  \(features[0])")
    print("Restored row 0:  \(restored[0])")
}
