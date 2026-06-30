import Playgrounds
import Quiver

// Find the Decision Boundary
// Before logistic regression (Recipe 73) squashes a score into a
// probability, it computes a raw linear score: the decision function.
// That score is the geometric heart of the classifier — its sign is
// the predicted class, and the point where it crosses zero is the
// decision boundary. Reading the score directly lets us see how far
// a sample sits from that boundary, and move the threshold by hand.

#Playground("Find the Decision Boundary") {

    // Hours studied → passed the exam (0 = failed, 1 = passed).
    let hours: [[Double]] = [
        [1.0], [2.0], [3.0], [4.0],
        [6.0], [7.0], [8.0], [9.0]
    ]
    let passed = [0, 0, 0, 0, 1, 1, 1, 1]

    let model = try LogisticRegression.fit(features: hours, labels: passed)

    // The decision function returns the raw log-odds before the sigmoid.
    // Negative → class 0, positive → class 1, zero → exactly on the
    // boundary. The magnitude is how confidently it lands on that side.
    let scores = model.decisionFunction([[2.0], [5.0], [8.0]])
    for (h, s) in zip([2.0, 5.0, 8.0], scores) {
        let side = s >= 0 ? "pass" : "fail"
        print("\(h)h → score \(String(format: "%+.3f", s)) (\(side))")
    }
    // 2.0h → -0.636 (fail), 5.0h → +0.636 (pass), 8.0h → +1.908 (pass).
    // The boundary — where the score crosses zero — sits between
    // 2 and 5 hours, so a 5-hour student already lands on the pass side.

    // The scalar overload reads one sample's signed distance from the boundary.
    let borderline = model.decisionFunction(5.0)
    print("5h log-odds:", String(format: "%.3f", borderline))  // 0.636
}
