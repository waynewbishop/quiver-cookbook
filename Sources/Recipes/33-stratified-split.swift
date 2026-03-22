import Playgrounds
import Quiver

// Stratified Split
// A regular train/test split can leave all examples of a rare
// class in one partition. If only 10% of samples are positive
// and they all end up in the test set, the model trains without
// ever seeing the positive class. Stratified splitting preserves
// the class proportions in both partitions.

#Playground("Stratified Split") {

    // Imbalanced dataset: 8 negative (0), 2 positive (1)
    let features: [[Double]] = [
        [1.0, 2.0], [2.0, 3.0], [1.5, 2.5], [3.0, 1.0],
        [2.5, 2.0], [1.0, 3.0], [2.0, 1.5], [3.0, 2.5],
        [8.0, 9.0], [7.5, 8.5]   // the rare positive class
    ]
    let labels = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1]

    // Stratified split: both partitions keep the 80/20 class ratio
    let (trainX, testX, trainY, testY) = features.stratifiedSplit(
        labels: labels, testRatio: 0.2, seed: 42
    )

    // Verify: the test set contains at least one positive example
    let testPositives = testY.filter { $0 == 1 }.count
    let trainPositives = trainY.filter { $0 == 1 }.count

    print("Train: \(trainX.count) samples (\(trainX[0].count) features), \(trainPositives) positive")
    print("Test:  \(testX.count) samples (\(testX[0].count) features), \(testPositives) positive")
    print("Class ratio preserved in both partitions")
}
