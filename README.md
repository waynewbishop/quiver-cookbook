# The Quiver Cookbook

The cookbook comprises interactive recipes for learning vector mathematics, numerical computing, and machine learning in Swift. Designed for developers exploring the math behind machine learning, recommendation engines, and data analysis. Each recipe is a single `.swift` file that runs interactively inside Xcode as a playground macro. This lightweight model allows developers to quickly test, learn and experiment with the Quiver API. 

## What is Quiver?

[Quiver](https://github.com/waynewbishop/quiver) expands the Swift ecosystem with a native, Swift-first approach to vector mathematics and numerical computing. Built as an extension on the standard `Array` type, the framework embraces Swift's emphasis on readability and expressiveness, offering mathematical operations that feel natural to iOS and macOS developers.

As a pure Swift library with zero external dependencies, Quiver runs on every Apple platform — iOS, macOS, watchOS, tvOS, and visionOS — as well as server-side Swift, Linux environments, and containerized deployments. Quiver is ideal for teaching environments, on-device processing, and any context where minimal dependencies and platform portability matter.

## Getting started

**Option 1 — Clone and explore:**
```bash
git clone https://github.com/waynewbishop/quiver-cookbook.git
```
Open in Xcode 26. Browse `recipes/`, pick one, run it.

**Option 2 — Single file download:**
1. Add [Quiver](https://github.com/waynewbishop/quiver) as an SPM dependency to any Xcode 26 project
2. Download a recipe `.swift` file from this repo
3. Drop it into your project and run

Each recipe uses the Xcode 26 `#Playground` macro, which shows results inline as you type.

## Recipes

### Vectors and geometry

**1. [How Far Is Home?](recipes/01-how-far-is-home.swift)**

Magnitude and distance both use the Pythagorean theorem, but they answer different questions. Magnitude measures how far a point sits from the origin — like asking "how far am I from home?" Distance measures the gap between any two points — like asking "how far is the coffee shop from the library?" This recipe shows that magnitude is actually a special case of distance where the starting point is always zero.

**2. [Normalize a Direction](recipes/02-normalize-a-direction.swift)**

A velocity vector like `[3, 4]` contains two pieces of information tangled together: how fast (magnitude = 5) and which way (the direction). Normalization separates them by dividing each component by the magnitude, producing a unit vector with length exactly 1.0. Once separated, we can point in any direction at any speed — the foundation of physics engines, game movement, and graphics rendering.

**3. [Are These Perpendicular?](recipes/03-are-these-perpendicular.swift)**

The dot product takes two vectors and returns a single number that reveals their angular relationship. A positive result means the vectors point in a similar direction. Zero means they're perpendicular — at a perfect 90° angle. A negative result means they point in opposite directions. This single operation is the building block for cosine similarity, projections, and nearly every ML algorithm.

### Similarity and search

**4. [Find the Most Similar Item](recipes/04-find-the-most-similar-item.swift)**

Cosine similarity measures how closely two vectors point in the same direction, producing a score from -1.0 (opposite) to 1.0 (identical). Unlike the raw dot product, cosine similarity ignores magnitude — so a vector `[3, 4]` and a vector `[6, 8]` score 1.0 because they point the same way, even though one is twice as long. This is exactly how recommendation engines rank products, songs, and articles by relevance to a user's preferences.

**5. [King − Man + Woman = Queen](recipes/05-king-minus-man-plus-woman.swift)**

Word embeddings represent words as vectors where geometric relationships encode meaning. The most famous demonstration: subtract the "man" vector from "king," add the "woman" vector, and the result lands nearest to "queen." This works because embeddings encode properties like gender and royalty as consistent directions in vector space — the same linear algebra we use for position and velocity also captures language.

**6. [Detect Near-Duplicates](recipes/06-detect-near-duplicates.swift)**

Given a collection of vectors, `findDuplicates` computes the cosine similarity of every pair and returns those exceeding a threshold. Two document embeddings that score 0.999 are saying almost exactly the same thing in different words. This is how content platforms detect plagiarism, search engines remove duplicate results, and product catalogs merge near-identical listings.

### Statistics

**7. [Describe a Dataset](recipes/07-describe-a-dataset.swift)**

The first thing a data scientist does with new data is compute a statistical profile: mean (the average), median (the middle value, less sensitive to extremes), standard deviation (typical spread from the mean), and quartiles (boundaries that divide data into four equal groups). This recipe computes all of them on a single array of exam scores — the starting point for any data analysis workflow.

**8. [Find the Outliers](recipes/08-find-the-outliers.swift)**

An outlier is a value that falls far from the rest of the data. The z-score method measures how many standard deviations each value sits from the mean — anything beyond a threshold (like 1.5 or 2.0) gets flagged. Boolean masking then splits the data into normal and flagged arrays without writing any loops. This is how sensor systems detect anomalies, financial platforms flag unusual transactions, and health apps identify irregular readings.

**9. [Smooth a Noisy Signal](recipes/09-smooth-a-noisy-signal.swift)**

Raw data from sensors, APIs, and user interactions often contains noise — random fluctuations that obscure the underlying trend. A rolling mean replaces each data point with the average of itself and its recent neighbors, dampening spikes while preserving the direction of change. Larger windows produce smoother curves but react more slowly to real changes — choosing the right window size is a fundamental tradeoff in signal processing.

**10. [Build a Histogram](recipes/10-build-a-histogram.swift)**

A histogram groups data into equal-width bins and counts how many values fall in each range, revealing the shape of a distribution. A bell curve clusters values around the mean with thin tails. A skewed distribution piles up on one side. A uniform distribution spreads values evenly. Seeing the shape tells you more about your data than any single number can — it's the visual foundation of exploratory data analysis.

### Matrices and transformations

**11. [Reshape Without Losing Data](recipes/11-reshape-without-losing-data.swift)**

A flat array of 12 numbers can be organized as a 3×4 grid, a 4×3 grid, a 2×6 grid, or any other shape whose dimensions multiply to 12. No data is added or removed — the same values flow into the new shape, filling row by row. Reshaping is how datasets move between the vector form that statistics expects and the matrix form that linear algebra and ML models require.

**12. [Rotate a Point 90 Degrees](recipes/12-rotate-a-point.swift)**

A 2×2 rotation matrix spins any vector around the origin without changing its length. Multiplying the matrix `[[0, -1], [1, 0]]` by the vector `[3, 4]` produces `[-4, 3]` — the same point rotated 90° counterclockwise. The matrix columns reveal where the x-axis and y-axis end up after rotation. This is how graphics engines, game physics, and coordinate systems perform geometric transformations.

**13. [Multiply Two Matrices](recipes/13-multiply-two-matrices.swift)**

Matrix multiplication computes each output cell as the dot product of one row from the first matrix and one column from the second. A 2×3 matrix times a 3×2 matrix produces a 2×2 result — the inner dimensions must match. This operation is the computational engine behind neural networks, coordinate transformations, and solving systems of linear equations.

**14. [Can This Matrix Be Inverted?](recipes/14-can-this-matrix-be-inverted.swift)**

A matrix inverse "undoes" the original transformation — multiplying a matrix by its inverse produces the identity matrix (the mathematical equivalent of multiplying by 1). The determinant tells you whether an inverse exists: if it's zero, the matrix is singular and has collapsed space into a lower dimension, losing information that can't be recovered. Linear regression uses matrix inversion internally to solve for optimal coefficients.

### Machine learning

**15. [Predict a House Price](recipes/15-predict-a-house-price.swift)**

Linear regression finds the best-fit line (or plane) through data points by computing coefficients that minimize prediction error. Given features like square footage, bedrooms, and age, the model learns how much each feature contributes to the price. The R² score measures how well the model fits — 1.0 is perfect, 0.0 means the model explains nothing. This is the most fundamental regression algorithm and the starting point for understanding all supervised learning.

**16. [Classify with Naive Bayes](recipes/16-classify-with-naive-bayes.swift)**

Gaussian Naive Bayes learns the mean and variance of each feature for each class during training. When predicting, it asks: "given this data point, which class makes it most probable?" The "naive" part assumes features are independent — rarely true in practice, but the simplification makes the model fast and surprisingly effective. It trains in a single pass through the data with no iteration, making it ideal for quick baselines and small datasets.

**17. [Find the Nearest Neighbor](recipes/17-find-the-nearest-neighbor.swift)**

K-Nearest Neighbors stores the entire training set and classifies new points by measuring distance to every training example, finding the K closest, and taking a majority vote. No parameters are learned — the data itself is the model. This makes training instant but prediction slower on large datasets. The choice of K controls sensitivity: small K follows noise, large K smooths boundaries.

**18. [Cluster Without Labels](recipes/18-cluster-without-labels.swift)**

K-Means is an unsupervised algorithm — it finds natural groupings in data that has no labels. You specify how many clusters (K) to look for. The algorithm assigns each point to the nearest centroid, recalculates centroids as the mean of each cluster's members, and repeats until assignments stabilize. It's how customer segmentation, image compression, and anomaly detection work when you have data but no predefined categories.

**19. [Scale Features Before Training](recipes/19-scale-features-before-training.swift)**

When features have vastly different magnitudes — a credit score (300-850) and an account balance (0-250,000) — the larger feature dominates distance calculations. A model trained on unscaled data essentially ignores the smaller feature. Feature scaling transforms all features to the same range (typically 0 to 1), ensuring each one contributes proportionally. This is critical for any distance-based algorithm including KNN, K-Means, and cosine similarity.

**20. [Split, Train, Evaluate](recipes/20-split-train-evaluate.swift)**

The most important rule in machine learning: never evaluate a model on the same data it trained on. Splitting data into training and test sets lets us measure how well the model generalizes to data it has never seen. This recipe runs the complete pipeline — split the data, train a classifier, predict on held-out examples, and measure accuracy, precision, recall, and F1 score. It's the workflow every ML project follows, regardless of model or domain.

## Learn the math

These recipes show what Quiver can do. The companion book [Swift Algorithms & Data Structures](https://waynewbishop.github.io/swift-algorithms/) teaches the mathematical foundations behind them — from Big O notation and data structures through vectors, matrices, transformations, and similarity operations. Chapters 20-23 build the linear algebra concepts that power recipes 01-06 and 11-14, and connect them to the machine learning models in recipes 15-20.

## Contribute

Have a recipe idea? Found something that could be improved? We'd love your input.

- **Request a recipe** — [open an issue](https://github.com/waynewbishop/quiver-cookbook/issues) describing the concept or scenario you'd like to see
- **Submit your own** — fork the repo, add a `.swift` file to `recipes/`, and open a pull request
- **Report a bug** — if a recipe produces incorrect results, let us know via a PR or issue

## Learn more

- [Quiver documentation](https://waynewbishop.github.io/quiver/documentation/quiver/) — full API reference and conceptual guides
- [Swift Algorithms & Data Structures](https://waynewbishop.github.io/swift-algorithms/) — the companion book
- [Quiver on GitHub](https://github.com/waynewbishop/quiver) — source code, issues, contributions
