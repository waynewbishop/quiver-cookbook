import Playgrounds
import Quiver

// Gradient Descent on House Prices
// LinearRegression solves the normal equation in one matrix expression.
// GradientDescent walks to the same minimum one iteration at a time.
// On a problem where both routes apply, the answers should agree —
// and watching that agreement happen is how the iterative route earns
// the trust it will need for models where no closed form exists.

#Playground("Gradient Descent on House Prices") {

    // Five homes: square footage and asking price.
    let sqft   = [[1000.0], [1500.0], [2000.0], [2500.0], [3000.0]]
    let prices = [150000.0, 200000.0, 260000.0, 310000.0, 370000.0]

    // Standardize the feature before iterating — the default learning rate
    // assumes unit-variance inputs and will diverge on raw-scale data.
    let scaler = StandardScaler.fit(features: sqft)
    let scaled = scaler.transform(sqft)

    // Closed-form answer in one pass — our oracle.
    let closedForm = try LinearRegression.fit(features: scaled, targets: prices)
    print("closed form:", closedForm.coefficients)

    // Same problem, walked to instead of solved.
    let iterative = try GradientDescent.fit(features: scaled, targets: prices)
    print("gradient descent:", iterative.coefficients)
    print(iterative)

    // The trajectory tells the story of the descent.
    let startLoss: Double = iterative.lossHistory.first ?? 0.0
    print("loss at start:", startLoss)
    print("loss at end:  ", iterative.finalLoss)
    print("iterations:   ", iterative.iterations)
}
