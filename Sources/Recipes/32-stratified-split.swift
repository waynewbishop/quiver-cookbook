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
    // Unlike trainTestSplit, this ensures the rare class appears
    // in both train and test — so the model sees positive examples
    let (trainX, testX, trainY, testY) = features.stratifiedSplit(
        labels: labels, testRatio: 0.2, seed: 42
    )

    // Train and evaluate — the split flows directly into the pipeline
    let model = GaussianNaiveBayes.fit(features: trainX, labels: trainY)
    let predictions = model.predict(testX)
    
    print(predictions.classificationReport(actual: testY))
}
