# Quiver Cookbook

Short, interactive recipes for learning vector mathematics, numerical computing, and machine learning in Swift.

Each recipe is a single `.swift` file you can run immediately in Xcode 26. No configuration, no boilerplate — just math that works.

## What is Quiver?

[Quiver](https://github.com/waynewbishop/quiver) is a Swift package for vector mathematics, numerical computing, and machine learning. It extends the standard `Array` type with 350+ operations — from dot products and matrix multiplication to cosine similarity and K-Means clustering. Pure Swift, zero dependencies, runs on every Apple platform and Linux.

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

Each recipe uses the Xcode 26 `#Playground` macro, which shows results inline as you type — the Swift equivalent of a Jupyter notebook.

## Recipes

### Vectors and geometry

| # | Recipe | What you'll learn |
|---|--------|-------------------|
| 01 | [How Far Is Home?](recipes/01-how-far-is-home.swift) | Magnitude vs distance — same theorem, different questions |
| 02 | [Normalize a Direction](recipes/02-normalize-a-direction.swift) | Separate "how much" from "which way" with unit vectors |
| 03 | [Are These Perpendicular?](recipes/03-are-these-perpendicular.swift) | Dot product reveals angle relationships between vectors |

### Similarity and search

| # | Recipe | What you'll learn |
|---|--------|-------------------|
| 04 | [Find the Most Similar Item](recipes/04-find-the-most-similar-item.swift) | Rank items by cosine similarity — the core of recommendation engines |
| 05 | [King − Man + Woman = Queen](recipes/05-king-minus-man-plus-woman.swift) | Vector arithmetic captures semantic relationships in word embeddings |
| 06 | [Detect Near-Duplicates](recipes/06-detect-near-duplicates.swift) | Find nearly identical vectors in a collection |

### Statistics

| # | Recipe | What you'll learn |
|---|--------|-------------------|
| 07 | [Describe a Dataset](recipes/07-describe-a-dataset.swift) | Mean, median, standard deviation, and quartiles in one pass |
| 08 | [Find the Outliers](recipes/08-find-the-outliers.swift) | Boolean masking with z-scores to split normal from unusual data |
| 09 | [Smooth a Noisy Signal](recipes/09-smooth-a-noisy-signal.swift) | Rolling mean reveals trends hidden in jittery data |
| 10 | [Build a Histogram](recipes/10-build-a-histogram.swift) | See the shape of your data — bell curve, skew, or spread |

### Matrices and transformations

| # | Recipe | What you'll learn |
|---|--------|-------------------|
| 11 | [Reshape Without Losing Data](recipes/11-reshape-without-losing-data.swift) | Same numbers, different grid — reshape between vectors and matrices |
| 12 | [Rotate a Point 90 Degrees](recipes/12-rotate-a-point.swift) | Matrix multiplication as geometric transformation |
| 13 | [Multiply Two Matrices](recipes/13-multiply-two-matrices.swift) | Row × column dot products, one cell at a time |
| 14 | [Can This Matrix Be Inverted?](recipes/14-can-this-matrix-be-inverted.swift) | Determinants, inverses, and singular matrices |

### Machine learning

| # | Recipe | What you'll learn |
|---|--------|-------------------|
| 15 | [Predict a House Price](recipes/15-predict-a-house-price.swift) | Linear regression — fit, predict, and evaluate with R² |
| 16 | [Classify with Naive Bayes](recipes/16-classify-with-naive-bayes.swift) | Probabilistic classification from mean and variance |
| 17 | [Find the Nearest Neighbor](recipes/17-find-the-nearest-neighbor.swift) | K-Nearest Neighbors — the data IS the model |
| 18 | [Cluster Without Labels](recipes/18-cluster-without-labels.swift) | K-Means discovers natural groupings in unlabeled data |
| 19 | [Scale Features Before Training](recipes/19-scale-features-before-training.swift) | Why unscaled features break distance-based models |
| 20 | [Split, Train, Evaluate](recipes/20-split-train-evaluate.swift) | The complete ML pipeline — holdout, train, and measure accuracy |

## Design

Every recipe follows three rules:

1. **10-15 lines of code** — readable in one screen
2. **Robust comments** — explain the math, not just the API
3. **Meaningful data** — exam scores, house prices, word embeddings — not abstract arrays

All computations are validated against Python (NumPy + scikit-learn). The validation script is included in this repo as `validate_recipes.py`.

## Learn more

- [Quiver documentation](https://waynewbishop.github.io/quiver/documentation/quiver/) — full API reference and conceptual guides
- [Swift Algorithms & Data Structures](https://waynewbishop.github.io/swift-algorithms/) — the companion book that teaches the math behind these recipes
- [Quiver on GitHub](https://github.com/waynewbishop/quiver) — source code, issues, contributions

## Requirements

- Xcode 26+
- Swift 5.9+
- [Quiver](https://github.com/waynewbishop/quiver) package dependency
