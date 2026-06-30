import Playgrounds
import Quiver

// Classify with Logistic Regression
// Naive Bayes (Recipe 16) counts statistics and KNN (Recipe 17)
// stores points and votes. Logistic regression is the first
// classifier that *learns* a decision boundary: it fits coefficients
// by gradient descent on cross-entropy loss, then turns a linear
// score into a probability with the sigmoid (Recipe 24). Predicting
// a yes-or-no outcome is the most common classification task in
// applied machine learning.

#Playground("Classify with Logistic Regression") {

    // Hours studied → passed the exam (0 = failed, 1 = passed).
    // A clean threshold sits somewhere around five hours.
    let hours: [[Double]] = [
        [1.0], [2.0], [3.0], [4.0],
        [6.0], [7.0], [8.0], [9.0]
    ]
    let passed = [0, 0, 0, 0, 1, 1, 1, 1]

    // Fit learns the coefficients by gradient descent. Throws if the
    // descent diverges, so the call is marked `try`.
    let model = try LogisticRegression.fit(features: hours, labels: passed)
    print(model)

    // Predict a class label (0 or 1) for new students.
    let predictions = model.predict([[2.5], [7.5]])
    print("predictions:", predictions)  // [0, 1]

    // Coefficients are available through the Coefficients protocol —
    // the same surface LinearRegression and Ridge expose.
    print("coefficients:", model.coefficients)

    // The scalar predict overload handles a single-feature model
    // without the nested-array ceremony.
    let oneStudent = model.predict(7.5)
    print("single prediction:", oneStudent)  // 1
}
