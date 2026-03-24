# The Quiver Cookbook — Vector Mathematics, Statistics, and ML Models in Swift

The cookbook comprises interactive recipes for learning vector mathematics, numerical computing, and machine learning in Swift. Designed for developers exploring the math behind machine learning, recommendation engines, and data analysis. Each recipe is a single `.swift` file that runs interactively inside Xcode as a playground macro. This lightweight model allows developers to quickly test, learn and experiment with the Quiver API. 

## What is Quiver?

[Quiver](https://github.com/waynewbishop/quiver) expands the Swift ecosystem with a native, Swift-first approach to vector mathematics and numerical computing. Built as an extension on the standard `Array` type, the framework embraces Swift's emphasis on readability and expressiveness, offering mathematical operations that feel natural to iOS and macOS developers.

As a pure Swift library with zero external dependencies, Quiver runs on every Apple platform — iOS, macOS, watchOS, tvOS, and visionOS — as well as server-side Swift, Linux environments, and containerized deployments. Quiver is ideal for teaching environments, on-device processing, and any context where minimal dependencies and platform portability matter.

## Getting started

```bash
git clone https://github.com/waynewbishop/quiver-cookbook.git
```

Open the project in Xcode 26. Quiver is included as a package dependency and resolves automatically — no manual setup. Browse `Sources/Recipes/`, pick a file, and run it. Each recipe uses the `#Playground` macro, which shows results inline as you type.

## Quick reference — by use case

| I want to... | Start with |
|---|---|
| Understand vectors and linear algebra | 1, 2, 3, 23 |
| Build a recommendation or search engine | 4, 5, 6, 21 |
| Analyze and explore a dataset | 7, 8, 9, 10, 22, 27 |
| Learn how matrix math powers ML | 11, 12, 13, 14, 28 |
| Train and evaluate an ML model | 15, 16, 17, 18, 20, 25, 26, 33 |
| Prepare data for machine learning | 19, 22, 24, 30, 32 |
| Find patterns in unlabeled data | 6, 18, 29 |
| Write numerical code without loops | 31 |

## Recipes

### Vectors and geometry

**1. [How Far Is Home?](Sources/Recipes/01-how-far-is-home.swift)**

Magnitude and distance both use the Pythagorean theorem, but they answer different questions. Magnitude measures how far a point sits from the origin — like asking "how far am I from home?" Distance measures the gap between any two points — like asking "how far is the coffee shop from the library?" This recipe shows that magnitude is actually a special case of distance where the starting point is always zero.

**2. [Normalize a Direction](Sources/Recipes/02-normalize-a-direction.swift)**

A velocity vector like `[3, 4]` contains two pieces of information tangled together: how fast (magnitude = 5) and which way (the direction). Normalization separates them by dividing each component by the magnitude, producing a unit vector with length exactly 1.0. Once separated, we can point in any direction at any speed — the foundation of physics engines, game movement, and graphics rendering.

**3. [Are These Perpendicular?](Sources/Recipes/03-are-these-perpendicular.swift)**

The dot product takes two vectors and returns a single number that reveals their angular relationship. A positive result means the vectors point in a similar direction. Zero means they're perpendicular — at a perfect 90° angle. A negative result means they point in opposite directions. This single operation is the building block for cosine similarity, projections, and nearly every ML algorithm.

### Similarity and search

**4. [Find the Most Similar Item](Sources/Recipes/04-find-the-most-similar-item.swift)**

Cosine similarity measures how closely two vectors point in the same direction, producing a score from -1.0 (opposite) to 1.0 (identical). Unlike the raw dot product, cosine similarity ignores magnitude — so a vector `[3, 4]` and a vector `[6, 8]` score 1.0 because they point the same way, even though one is twice as long. This is exactly how recommendation engines rank products, songs, and articles by relevance to a user's preferences.

**5. [King − Man + Woman = Queen](Sources/Recipes/05-king-minus-man-plus-woman.swift)**

Word embeddings represent words as vectors where geometric relationships encode meaning. The most famous demonstration: subtract the "man" vector from "king," add the "woman" vector, and the result lands nearest to "queen." This works because embeddings encode properties like gender and royalty as consistent directions in vector space — the same linear algebra we use for position and velocity also captures language.

**6. [Detect Near-Duplicates](Sources/Recipes/06-detect-near-duplicates.swift)**

Given a collection of vectors, `findDuplicates` computes the cosine similarity of every pair and returns those exceeding a threshold. Two document embeddings that score 0.999 are saying almost exactly the same thing in different words. This is how content platforms detect plagiarism, search engines remove duplicate results, and product catalogs merge near-identical listings.

### Statistics

**7. [Describe a Dataset](Sources/Recipes/07-describe-a-dataset.swift)**

The first thing a data scientist does with new data is compute a statistical profile: mean (the average), median (the middle value, less sensitive to extremes), standard deviation (typical spread from the mean), and quartiles (boundaries that divide data into four equal groups). This recipe computes all of them on a single array of exam scores — the starting point for any data analysis workflow.

**8. [Find the Outliers](Sources/Recipes/08-find-the-outliers.swift)**

An outlier is a value that falls far from the rest of the data. The z-score method measures how many standard deviations each value sits from the mean — anything beyond a threshold (like 1.5 or 2.0) gets flagged. Boolean masking then splits the data into normal and flagged arrays without writing any loops. This is how sensor systems detect anomalies, financial platforms flag unusual transactions, and health apps identify irregular readings.

**9. [Smooth a Noisy Signal](Sources/Recipes/09-smooth-a-noisy-signal.swift)**

Raw data from sensors, APIs, and user interactions often contains noise — random fluctuations that obscure the underlying trend. A rolling mean replaces each data point with the average of itself and its recent neighbors, dampening spikes while preserving the direction of change. Larger windows produce smoother curves but react more slowly to real changes — choosing the right window size is a fundamental tradeoff in signal processing.

**10. [Build a Histogram](Sources/Recipes/10-build-a-histogram.swift)**

A histogram groups data into equal-width bins and counts how many values fall in each range, revealing the shape of a distribution. A bell curve clusters values around the mean with thin tails. A skewed distribution piles up on one side. A uniform distribution spreads values evenly. Seeing the shape tells you more about your data than any single number can — it's the visual foundation of exploratory data analysis.

### Matrices and transformations

**11. [Reshape Without Losing Data](Sources/Recipes/11-reshape-without-losing-data.swift)**

A flat array of 12 numbers can be organized as a 3×4 grid, a 4×3 grid, a 2×6 grid, or any other shape whose dimensions multiply to 12. No data is added or removed — the same values flow into the new shape, filling row by row. Reshaping is how datasets move between the vector form that statistics expects and the matrix form that linear algebra and ML models require.

**12. [Rotate a Point 90 Degrees](Sources/Recipes/12-rotate-a-point.swift)**

A 2×2 rotation matrix spins any vector around the origin without changing its length. Multiplying the matrix `[[0, -1], [1, 0]]` by the vector `[3, 4]` produces `[-4, 3]` — the same point rotated 90° counterclockwise. The matrix columns reveal where the x-axis and y-axis end up after rotation. This is how graphics engines, game physics, and coordinate systems perform geometric transformations.

**13. [Multiply Two Matrices](Sources/Recipes/13-multiply-two-matrices.swift)**

Matrix multiplication computes each output cell as the dot product of one row from the first matrix and one column from the second. A 2×3 matrix times a 3×2 matrix produces a 2×2 result — the inner dimensions must match. This operation is the computational engine behind neural networks, coordinate transformations, and solving systems of linear equations.

**14. [Can This Matrix Be Inverted?](Sources/Recipes/14-can-this-matrix-be-inverted.swift)**

A matrix inverse "undoes" the original transformation — multiplying a matrix by its inverse produces the identity matrix (the mathematical equivalent of multiplying by 1). The determinant tells you whether an inverse exists: if it's zero, the matrix is singular and has collapsed space into a lower dimension, losing information that can't be recovered. Linear regression uses matrix inversion internally to solve for optimal coefficients.

### Machine learning

**15. [Predict a House Price](Sources/Recipes/15-predict-a-house-price.swift)**

Linear regression finds the best-fit line (or plane) through data points by computing coefficients that minimize prediction error. Given features like square footage, bedrooms, and age, the model learns how much each feature contributes to the price. The R² score measures how well the model fits — 1.0 is perfect, 0.0 means the model explains nothing. This is the most fundamental regression algorithm and the starting point for understanding all supervised learning.

**16. [Classify with Naive Bayes](Sources/Recipes/16-classify-with-naive-bayes.swift)**

Gaussian Naive Bayes learns the mean and variance of each feature for each class during training. When predicting, it asks: "given this data point, which class makes it most probable?" The "naive" part assumes features are independent — rarely true in practice, but the simplification makes the model fast and surprisingly effective. It trains in a single pass through the data with no iteration, making it ideal for quick baselines and small datasets.

**17. [Find the Nearest Neighbor](Sources/Recipes/17-find-the-nearest-neighbor.swift)**

K-Nearest Neighbors stores the entire training set and classifies new points by measuring distance to every training example, finding the K closest, and taking a majority vote. No parameters are learned — the data itself is the model. This makes training instant but prediction slower on large datasets. The choice of K controls sensitivity: small K follows noise, large K smooths boundaries.

**18. [Cluster Without Labels](Sources/Recipes/18-cluster-without-labels.swift)**

K-Means is an unsupervised algorithm — it finds natural groupings in data that has no labels. You specify how many clusters (K) to look for. The algorithm assigns each point to the nearest centroid, recalculates centroids as the mean of each cluster's members, and repeats until assignments stabilize. It's how customer segmentation, image compression, and anomaly detection work when you have data but no predefined categories.

**19. [Scale Features Before Training](Sources/Recipes/19-scale-features-before-training.swift)**

When features have vastly different magnitudes — a credit score (300-850) and an account balance (0-250,000) — the larger feature dominates distance calculations. A model trained on unscaled data essentially ignores the smaller feature. Feature scaling transforms all features to the same range (typically 0 to 1), ensuring each one contributes proportionally. This is critical for any distance-based algorithm including KNN, K-Means, and cosine similarity.

**20. [Split, Train, Evaluate](Sources/Recipes/20-split-train-evaluate.swift)**

The most important rule in machine learning: never evaluate a model on the same data it trained on. Splitting data into training and test sets lets us measure how well the model generalizes to data it has never seen. This recipe runs the complete pipeline — split the data, train a classifier, predict on held-out examples, and measure accuracy, precision, recall, and F1 score. It's the workflow every ML project follows, regardless of model or domain.

### Search and text

**21. [Search by Meaning](Sources/Recipes/21-search-by-meaning.swift)**

Traditional search matches keywords — if you search "fast running," it only finds documents containing those exact words. Semantic search matches meaning — "jogging sprint" ranks highly because it means something similar, even though it shares no words with the query. This recipe builds the full pipeline: tokenize text into words, look up each word's vector representation, average them into a document vector, then rank a catalog by cosine similarity.

### Data organization

**22. [Organize Data with Panel](Sources/Recipes/22-organize-data-with-panel.swift)**

Raw arrays of numbers are hard to work with when each column represents something different — age, income, credit score. Panel gives your data named columns so you can access, filter, inspect, and split data without losing track of which numbers mean what. This recipe shows how to create a Panel, run `describe()` for a statistical summary, filter rows by condition, and split into training and test sets with columns staying aligned automatically.

### Projections

**23. [Project a Vector onto Another](Sources/Recipes/23-project-a-vector.swift)**

Projection decomposes one vector into two parts: the component that lies along another vector (parallel) and the component perpendicular to it (orthogonal). Together they reconstruct the original exactly. The classic example is force on a ramp — how much pushes you forward along the surface, and how much pushes you into it. This decomposition appears in physics, graphics, and ML wherever you need to separate a signal into independent components.

### Activation functions

**24. [From Scores to Probabilities](Sources/Recipes/24-from-scores-to-probabilities.swift)**

Raw model outputs are just numbers — they could be any magnitude, positive or negative. Activation functions convert them into values we can interpret. Sigmoid squishes a single score into the range 0 to 1, answering "how likely is this?" SoftMax takes a set of scores and distributes them into probabilities that sum to exactly 1.0, answering "which category is most likely?" These two functions are the final step in nearly every classification model.

### Model evaluation

**25. [Evaluate a Classifier](Sources/Recipes/25-evaluate-a-classifier.swift)**

Accuracy alone can be misleading — if 95% of emails are not spam, a model that always predicts "not spam" gets 95% accuracy while catching zero spam. Precision measures how many of the model's positive predictions were actually correct (few false alarms). Recall measures how many actual positives the model caught (few missed cases). F1 balances both into a single score. This recipe shows all four metrics on a concrete set of predictions.

**26. [Evaluate a Regression Model](Sources/Recipes/26-evaluate-a-regression.swift)**

A classifier is right or wrong. A regression model is close or far — so we measure how far off the predictions are. R² tells us how much variation the model explains (1.0 = perfect, 0.0 = useless). MSE penalizes large errors heavily by squaring the differences. RMSE converts back to the original units so we can say "on average, predictions are off by about $4K." Together these three metrics tell the full story of a regression model's quality.

**27. [Correlation Matrix](Sources/Recipes/27-correlation-matrix.swift)**

Correlation measures how two variables move together: +1.0 means they rise and fall in lockstep, -1.0 means one rises when the other falls, and 0.0 means no relationship at all. A correlation matrix compares every variable against every other in one computation. This recipe compares temperature and ice cream sales — a correlation near 1.0 reveals that hotter days drive more sales. Before training an ML model, correlation helps identify which features are redundant and which carry independent signal.

### Linear systems

**28. [Solve a Linear System](Sources/Recipes/28-solve-a-linear-system.swift)**

Many real-world problems reduce to a set of equations with multiple unknowns — two products with unknown prices, three ingredients with unknown proportions. In matrix form, these become A × x = b. If A is invertible, the solution is x = A⁻¹ × b — the matrix inverse isolates the unknowns in one operation. This recipe solves a two-product pricing problem and verifies the answer by plugging the results back into the original equations.

### Clustering

**29. [Find the Best K](Sources/Recipes/29-find-the-best-k.swift)**

K-Means requires you to choose K — the number of clusters — before running. Too few and distinct groups get merged. Too many and natural groups get split. The elbow method runs K-Means for each K and measures inertia (total distance from points to centroids). The "elbow" in the curve — where improvement drops sharply then levels off — reveals the natural number of groups in the data. This recipe runs the full elbow analysis and prints the curve.

### Array generation

**30. [Generate Arrays](Sources/Recipes/30-generate-arrays.swift)**

Numerical computing starts with creating arrays of specific shapes and values. Instead of writing loops or array literals, generation functions produce arrays from a description: "give me 5 zeros," "100 values evenly spaced from 0 to 10," or "200 samples from a normal distribution." This recipe covers `zeros`, `ones`, `linspace`, `arange`, and `randomNormal` — the building blocks that appear in nearly every other recipe.

### Broadcasting

**31. [Broadcasting](Sources/Recipes/31-broadcasting.swift)**

Broadcasting applies a scalar operation to every element in an array without writing a loop. The Fahrenheit-to-Celsius formula `(F - 32) × 5/9` becomes `(fahrenheit - 32.0) * (5.0 / 9.0)` — the code reads exactly like the math. This recipe shows scalar arithmetic, z-score standardization, and why broadcasting eliminates the `for` loops and `.map` closures that clutter numerical code.

### Stratified splitting

**32. [Stratified Split](Sources/Recipes/32-stratified-split.swift)**

A regular train/test split can leave all examples of a rare class in one partition. If only 10% of samples are positive and they all end up in the test set, the model trains without ever seeing the positive class. Stratified splitting preserves the class proportions in both partitions, ensuring the model sees representative examples of every class during training.

### Testing equality

**33. [Testing Equality](Sources/Recipes/33-testing-equality.swift)**

Quiver's models support direct comparison with `==`. When two training runs use the same data and the same seed, the models and their clusters are guaranteed identical. This recipe trains K-Means twice with the same seed and confirms equality at both the model level and the cluster level — then shows that a different seed produces a different result. Useful for unit tests, debugging, and verifying pipeline stability.

## Companion book

This cookbook is companion to [Swift Algorithms & Data Structures](https://waynewbishop.github.io/swift-algorithms/), a comprehensive guide that teaches algorithmic thinking through hands-on Swift examples.

## Contribute

Have a recipe idea? Found something that could be improved? We'd love your input.

- **Request a recipe** — [open an issue](https://github.com/waynewbishop/quiver-cookbook/issues) describing the concept or scenario you'd like to see
- **Submit your own** — fork the repo, add a `.swift` file to `recipes/`, and open a pull request
- **Report a bug** — if a recipe produces incorrect results, let us know via a PR or issue

## Learn more

- [Quiver documentation](https://waynewbishop.github.io/quiver/documentation/quiver/) — full API reference and conceptual guides
- [Swift Algorithms & Data Structures](https://waynewbishop.github.io/swift-algorithms/) — the companion book
- [Quiver on GitHub](https://github.com/waynewbishop/quiver) — source code, issues, contributions
